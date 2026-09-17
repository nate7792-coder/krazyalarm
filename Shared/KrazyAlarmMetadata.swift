import AlarmKit

nonisolated struct KrazyAlarmMetadata: AlarmMetadata, Codable, Hashable, Sendable {
    let label: String
    let toneName: String
}

