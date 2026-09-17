import ActivityKit
import AlarmKit
import SwiftUI
import WidgetKit

struct AlarmLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AlarmAttributes<KrazyAlarmMetadata>.self) { context in
            HStack(spacing: 14) {
                Image(systemName: "alarm.waves.left.and.right.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
                VStack(alignment: .leading) {
                    Text(context.attributes.metadata?.label ?? "KrazyAlarm")
                        .font(.headline)
                    Text("Snooze active")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding()
            .activityBackgroundTint(.black.opacity(0.85))
            .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "alarm.fill").foregroundStyle(.red)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.metadata?.label ?? "KrazyAlarm")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Guardian snooze is active")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } compactLeading: {
                Image(systemName: "alarm.fill").foregroundStyle(.red)
            } compactTrailing: {
                Text("zzz")
            } minimal: {
                Image(systemName: "alarm.fill").foregroundStyle(.red)
            }
        }
    }
}

