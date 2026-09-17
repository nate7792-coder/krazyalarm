# Installing KrazyAlarm on Nathan's iPhone

The source is complete, but Apple only permits native iPhone apps to be compiled and signed with Xcode on a Mac. Windows can store and edit the source, but cannot produce the signed iPhone app by itself.

## Fastest personal-install route

1. Use any Mac that can run Xcode 26.
2. Install Xcode from the Mac App Store and sign in with an Apple ID.
3. Install Homebrew if needed, then run `brew install xcodegen`.
4. Transfer the entire `KrazyAlarm` folder to the Mac.
5. Open Terminal in that folder and run:

   ```sh
   xcodegen generate
   open KrazyAlarm.xcodeproj
   ```

6. In Xcode, choose the KrazyAlarm project, select the KrazyAlarm target, open **Signing & Capabilities**, and select the correct personal team.
7. Plug in the iPhone 12, trust the Mac, select the phone as the destination, and click Run.
8. If iOS asks, enable Developer Mode under **Settings → Privacy & Security → Developer Mode**.
9. Launch KrazyAlarm, press **Allow Alarms**, create a near-future test alarm, lock the phone, and verify sound, Stop, and Snooze.

## Before depending on it

- Test with Silent Mode enabled.
- Test with a Focus mode enabled.
- Test all eight sounds.
- Confirm the selected 5/6/7-day repeat pattern.
- Keep at least one separate backup alarm until the app has passed several real mornings.

With a free Apple developer account, a personal development installation may require periodic re-signing. TestFlight distribution requires the Apple Developer Program.

