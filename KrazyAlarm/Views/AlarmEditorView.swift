import SwiftUI

struct AlarmEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @State var profile: AlarmProfile
    let onSave: (AlarmProfile) -> Void

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Alarm time", selection: Binding(get: { profile.date }, set: { profile.date = $0 }), displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)

                Section("Alarm") {
                    TextField("Label", text: $profile.label)
                    Picker("Schedule", selection: $profile.repeatMode) {
                        ForEach(RepeatMode.allCases) { mode in
                            Text("\(mode.title) · \(mode.detail)").tag(mode)
                        }
                    }
                    Picker("Snooze", selection: $profile.snoozeMinutes) {
                        ForEach([5, 9, 10, 15], id: \.self) { minutes in
                            Text("\(minutes) minutes").tag(minutes)
                        }
                    }
                    Picker("Sound", selection: $profile.tone) {
                        ForEach(AlarmTone.allCases) { tone in
                            Text(tone.rawValue).tag(tone)
                        }
                    }
                    Toggle("Enabled", isOn: $profile.isEnabled)
                        .tint(.red)
                }
            }
            .navigationTitle("Edit Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(profile)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

