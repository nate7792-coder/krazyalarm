import AlarmKit
import Combine
import Foundation

@MainActor
final class AlarmStore: ObservableObject {
    @Published var alarms: [AlarmProfile] {
        didSet { save() }
    }
    @Published var use24HourTime: Bool {
        didSet { UserDefaults.standard.set(use24HourTime, forKey: Keys.use24Hour) }
    }
    @Published var statusMessage: String?

    private let scheduler = AlarmScheduler()

    private enum Keys {
        static let alarms = "krazyalarm.profiles"
        static let use24Hour = "krazyalarm.use24Hour"
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: Keys.alarms),
           let decoded = try? JSONDecoder().decode([AlarmProfile].self, from: data),
           decoded.count == 3 {
            alarms = decoded
        } else {
            alarms = AlarmProfile.defaults
        }
        use24HourTime = UserDefaults.standard.bool(forKey: Keys.use24Hour)
    }

    func requestAuthorization() async {
        do {
            let state = try await scheduler.requestAuthorization()
            statusMessage = state == .authorized ? "Alarms are authorized." : "Alarm permission was not granted."
        } catch {
            statusMessage = "Could not request alarm permission: \(error.localizedDescription)"
        }
    }

    func apply(_ profile: AlarmProfile) async {
        guard let index = alarms.firstIndex(where: { $0.id == profile.id }) else { return }
        alarms[index] = profile
        do {
            if profile.isEnabled {
                try await scheduler.schedule(profile)
                statusMessage = "\(profile.label) is armed."
            } else {
                try scheduler.cancel(profile.id)
                statusMessage = "\(profile.label) is off."
            }
        } catch {
            alarms[index].isEnabled = false
            statusMessage = "Alarm could not be scheduled: \(error.localizedDescription)"
        }
    }

    func toggle(_ profile: AlarmProfile, enabled: Bool) async {
        var updated = profile
        updated.isEnabled = enabled
        await apply(updated)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(alarms) else { return }
        UserDefaults.standard.set(data, forKey: Keys.alarms)
    }
}
