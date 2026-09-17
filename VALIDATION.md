# Validation report

Checked in the build workspace on 2026-09-17:

- Project contains exactly three default alarm profiles.
- All JSON asset-catalog manifests parse successfully.
- Both property lists parse successfully.
- App icon is a valid 1024 × 1024 PNG.
- Eight WAV sounds exist and use 44.1 kHz, mono, 16-bit PCM.
- Every sound resource referenced by `AlarmTone` exists.
- Source bundle contains no generated build products or signing credentials.
- GitHub Actions workflow parses as valid YAML and targets GitHub's macOS 26
  runner for an unsigned iOS Simulator build.
- An explicit shared `KrazyAlarm` scheme is declared for command-line builds.

Not yet checked:

- Xcode compilation and signing have not yet run. Pushing this source to GitHub
  will perform the first unsigned compilation check automatically.
- Real-device AlarmKit behavior, which requires an iPhone running iOS 26.

The first Mac/Xcode pass should therefore be treated as a build-validation pass. The installation checklist in `INSTALL.md` includes a near-future test alarm before relying on the app for work.
