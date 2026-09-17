import SwiftUI

@main
struct KrazyAlarmApp: App {
    @StateObject private var store = AlarmStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }
}

