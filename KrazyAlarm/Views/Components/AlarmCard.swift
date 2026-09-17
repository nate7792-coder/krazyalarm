import SwiftUI

struct AlarmCard: View {
    let profile: AlarmProfile
    let use24HourTime: Bool
    let onEdit: () -> Void
    let onToggle: (Bool) -> Void

    private var timeText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = use24HourTime ? "HH:mm" : "h:mm a"
        return formatter.string(from: profile.date)
    }

    var body: some View {
        Button(action: onEdit) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(profile.label)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text(timeText)
                            .font(.system(size: 43, weight: .light, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Toggle("", isOn: Binding(get: { profile.isEnabled }, set: onToggle))
                        .labelsHidden()
                        .tint(.red)
                }

                HStack(spacing: 16) {
                    Label(profile.repeatMode.detail, systemImage: "calendar")
                    Label("\(profile.snoozeMinutes) min", systemImage: "zzz")
                    Label(profile.tone.rawValue, systemImage: "music.note")
                        .lineLimit(1)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(.white.opacity(0.065))
                    .stroke(.white.opacity(0.10), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

