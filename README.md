# KrazyAlarm

KrazyAlarm is a native iPhone alarm app inspired by Nathan's missing DAYBETTER clock. It uses Apple's AlarmKit so alarms can appear on the Lock Screen, in StandBy, and through system alarm presentation on iOS 26.

## Version 1 features

- Three named alarm slots
- 5-day (Monday–Friday), 6-day (Monday–Saturday), and 7-day schedules
- 5, 9, 10, or 15 minute snooze
- Eight original bundled alarm sounds
- 12-hour or 24-hour clock display
- Full-screen adjustable warm/red night light
- Gothic guardian app icon

Room-temperature sensing is intentionally not included: an iPhone has no exposed ambient-room-temperature sensor. Outdoor weather can be added later with WeatherKit.

## Build requirements

- macOS with Xcode 26 or newer
- An iPhone running iOS 26 or newer
- A free or paid Apple developer account for device signing
- XcodeGen (`brew install xcodegen`)

## Build

1. Copy this folder to a Mac.
2. In Terminal, enter this folder and run `xcodegen generate`.
3. Open `KrazyAlarm.xcodeproj` in Xcode.
4. Select the **KrazyAlarm** target, then **Signing & Capabilities**, and choose your Apple ID team.
5. Connect the iPhone, select it as the run destination, and press Run.
6. The first time the app schedules an alarm, approve the AlarmKit permission request.

See `INSTALL.md` for the complete handoff checklist.

## Free GitHub macOS build check

The repository includes `.github/workflows/macos-build-check.yml`. Every push to
`main`, every pull request, and every manual run will:

1. Start a GitHub-hosted macOS 26 machine.
2. Generate `KrazyAlarm.xcodeproj` with XcodeGen.
3. Compile the app and widget against the iOS Simulator SDK with signing disabled.
4. Save the full Xcode log as a downloadable workflow artifact for 14 days.

This proves whether the source compiles with Xcode, but it does **not** sign the
app or install it on an iPhone. Follow `GITHUB_ACTIONS.md` to put the source on
GitHub and run the check from Windows or Linux.

## Important reliability note

AlarmKit provides the system alarm behavior; KrazyAlarm does not try to fake an alarm with ordinary notifications. Still, test every tone and schedule on the actual iPhone before relying on it for work.
