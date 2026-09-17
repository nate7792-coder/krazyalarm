import AlarmKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: AlarmStore
    @State private var selectedAlarm: AlarmProfile?
    @State private var showingNightLight = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    header

                    ForEach(store.alarms) { alarm in
                        AlarmCard(
                            profile: alarm,
                            use24HourTime: store.use24HourTime,
                            onEdit: { selectedAlarm = alarm },
                            onToggle: { enabled in
                                Task { await store.toggle(alarm, enabled: enabled) }
                            }
                        )
                    }

                    settings

                    if let message = store.statusMessage {
                        Text(message)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
            .background(background)
            .navigationTitle("KrazyAlarm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNightLight = true
                    } label: {
                        Image(systemName: "moon.stars.fill")
                    }
                }
            }
            .sheet(item: $selectedAlarm) { alarm in
                AlarmEditorView(profile: alarm) { updated in
                    Task { await store.apply(updated) }
                }
            }
            .fullScreenCover(isPresented: $showingNightLight) {
                NightLightView()
            }
        }
    }

    private var header: some View {
        HStack(spacing: 14) {
            Image(systemName: "alarm.waves.left.and.right.fill")
                .font(.system(size: 34))
                .foregroundStyle(.red)
                .frame(width: 58, height: 58)
                .background(.red.opacity(0.12), in: Circle())
            VStack(alignment: .leading, spacing: 3) {
                Text("Guardian awake")
                    .font(.title2.bold())
                Text("Three alarms. Zero nonsense.")
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 6)
    }

    private var settings: some View {
        VStack(spacing: 0) {
            Toggle(isOn: $store.use24HourTime) {
                Label("24-hour time", systemImage: "clock")
            }
            .tint(.red)
            .padding(16)

            Divider().padding(.leading, 16)

            Button {
                Task { await store.requestAuthorization() }
            } label: {
                Label("Allow system alarms", systemImage: "bell.badge.fill")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
            }
            .buttonStyle(.plain)
        }
        .background(.white.opacity(0.065), in: RoundedRectangle(cornerRadius: 22))
    }

    private var background: some View {
        ZStack {
            Color.black
            RadialGradient(colors: [.red.opacity(0.16), .clear], center: .topTrailing, startRadius: 10, endRadius: 520)
        }
        .ignoresSafeArea()
    }
}

