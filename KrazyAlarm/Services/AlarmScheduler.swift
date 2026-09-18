import ActivityKit
import AlarmKit
import SwiftUI

@MainActor
final class AlarmScheduler {
    private let manager = AlarmManager.shared

    func requestAuthorization() async throws -> AlarmManager.AuthorizationState {
        if manager.authorizationState == .notDetermined {
            return try await manager.requestAuthorization()
        }
        return manager.authorizationState
    }

    func schedule(_ profile: AlarmProfile) async throws {
        let authorization = try await requestAuthorization()
        guard authorization == .authorized else {
            throw SchedulerError.notAuthorized
        }

        try? manager.cancel(id: profile.id)

        let time = Alarm.Schedule.Relative.Time(hour: profile.hour, minute: profile.minute)
        let recurrence = Alarm.Schedule.Relative.Recurrence.weekly(weekdays(for: profile.repeatMode))
        let relative = Alarm.Schedule.Relative(time: time, repeats: recurrence)
        let schedule = Alarm.Schedule.relative(relative)

        let stopButton = AlarmButton(text: "Stop", textColor: .white, systemImageName: "stop.fill")
        let snoozeButton = AlarmButton(text: "Snooze", textColor: .white, systemImageName: "zzz")
        let alert = AlarmPresentation.Alert(
            title: "KrazyAlarm",
            stopButton: stopButton,
            secondaryButton: snoozeButton,
            secondaryButtonBehavior: .countdown
        )
        let countdown = AlarmPresentation.Countdown(
            title: "Snoozing",
            pauseButton: AlarmButton(text: "Pause", textColor: .white, systemImageName: "pause.fill")
        )
        let paused = AlarmPresentation.Paused(
            title: "Snooze paused",
            resumeButton: AlarmButton(text: "Resume", textColor: .white, systemImageName: "play.fill")
        )
        let presentation = AlarmPresentation(alert: alert, countdown: countdown, paused: paused)
        let metadata = KrazyAlarmMetadata(label: profile.label, toneName: profile.tone.rawValue)
        let attributes = AlarmAttributes(presentation: presentation, metadata: metadata, tintColor: .red)
        let duration = Alarm.CountdownDuration(
            preAlert: nil,
            postAlert: TimeInterval(profile.snoozeMinutes * 60)
        )
        let sound = AlertConfiguration.AlertSound.named(profile.tone.resourceName)
        let configuration = AlarmManager.AlarmConfiguration<KrazyAlarmMetadata>(
            countdownDuration: duration,
            schedule: schedule,
            attributes: attributes,
            sound: sound
        )

        _ = try await manager.schedule(id: profile.id, configuration: configuration)
    }

    func cancel(_ id: UUID) throws {
        try manager.cancel(id: id)
    }

    private func weekdays(for mode: RepeatMode) -> [Locale.Weekday] {
        switch mode {
        case .fiveDay:
            [.monday, .tuesday, .wednesday, .thursday, .friday]
        case .sixDay:
            [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        case .sevenDay:
            [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        }
    }

    enum SchedulerError: LocalizedError {
        case notAuthorized

        var errorDescription: String? {
            "KrazyAlarm needs permission to schedule system alarms."
        }
    }
}
