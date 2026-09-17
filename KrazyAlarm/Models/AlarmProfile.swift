import Foundation

enum RepeatMode: String, Codable, CaseIterable, Identifiable {
    case fiveDay
    case sixDay
    case sevenDay

    var id: String { rawValue }

    var title: String {
        switch self {
        case .fiveDay: "5 days"
        case .sixDay: "6 days"
        case .sevenDay: "7 days"
        }
    }

    var detail: String {
        switch self {
        case .fiveDay: "Mon–Fri"
        case .sixDay: "Mon–Sat"
        case .sevenDay: "Every day"
        }
    }
}

enum AlarmTone: String, Codable, CaseIterable, Identifiable {
    case crimsonBell = "Crimson Bell"
    case guardianPulse = "Guardian Pulse"
    case ironChime = "Iron Chime"
    case dawnRise = "Dawn Rise"
    case nightSignal = "Night Signal"
    case forge = "The Forge"
    case krazyBeep = "Krazy Beep"
    case softWake = "Soft Wake"

    var id: String { rawValue }

    var resourceName: String {
        switch self {
        case .crimsonBell: "CrimsonBell"
        case .guardianPulse: "GuardianPulse"
        case .ironChime: "IronChime"
        case .dawnRise: "DawnRise"
        case .nightSignal: "NightSignal"
        case .forge: "Forge"
        case .krazyBeep: "KrazyBeep"
        case .softWake: "SoftWake"
        }
    }
}

struct AlarmProfile: Identifiable, Codable, Hashable {
    var id: UUID
    var label: String
    var hour: Int
    var minute: Int
    var isEnabled: Bool
    var repeatMode: RepeatMode
    var snoozeMinutes: Int
    var tone: AlarmTone

    var date: Date {
        get {
            Calendar.current.date(from: DateComponents(hour: hour, minute: minute)) ?? .now
        }
        set {
            hour = Calendar.current.component(.hour, from: newValue)
            minute = Calendar.current.component(.minute, from: newValue)
        }
    }

    static let defaults: [AlarmProfile] = [
        AlarmProfile(id: UUID(), label: "Work", hour: 6, minute: 30, isEnabled: false, repeatMode: .fiveDay, snoozeMinutes: 9, tone: .guardianPulse),
        AlarmProfile(id: UUID(), label: "Backup", hour: 6, minute: 45, isEnabled: false, repeatMode: .sixDay, snoozeMinutes: 9, tone: .crimsonBell),
        AlarmProfile(id: UUID(), label: "Day Off", hour: 8, minute: 0, isEnabled: false, repeatMode: .sevenDay, snoozeMinutes: 10, tone: .softWake)
    ]
}

