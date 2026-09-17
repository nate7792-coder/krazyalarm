# Free macOS build checking with GitHub Actions

KrazyAlarm includes a workflow that asks a GitHub-hosted Mac to generate the
Xcode project and perform an unsigned iOS Simulator build. No Apple developer
membership, signing certificate, or Mac is needed for this build check.

## One-time setup from Windows

1. Sign in to GitHub as `nate7792-coder`.
2. Create a new repository named `krazyalarm` at:
   `https://github.com/new`
3. Choose **Private** unless you intentionally want the source public.
4. Do not add a README, `.gitignore`, or license when creating the repository.
5. Extract the KrazyAlarm source ZIP.
6. Open PowerShell inside the extracted `KrazyAlarm` folder—the folder containing
   `project.yml` and `README.md`.
7. Run:

   ```powershell
   git init
   git branch -M main
   git add .
   git commit -m "Add KrazyAlarm and macOS build check"
   git remote add origin https://github.com/nate7792-coder/krazyalarm.git
   git push -u origin main
   ```

If Git asks who you are before the commit, run these once and retry the commit:

```powershell
git config --global user.name "Nathan Barber"
git config --global user.email "YOUR_GITHUB_EMAIL"
```

## Read the result

1. Open `https://github.com/nate7792-coder/krazyalarm/actions`.
2. Open **KrazyAlarm macOS Build Check**.
3. Open the newest run and select **Unsigned iOS simulator build**.
4. A green check means Xcode generated and compiled the project successfully.
5. A red X means the build found a source or project error. Open the failing step
   and copy its error text for repair.
6. The complete `KrazyAlarm-xcodebuild-log` is available under **Artifacts** at
   the bottom of the workflow-run page for 14 days.

## Run it again without changing code

Open the workflow, choose **Run workflow**, keep branch `main`, and press the
green **Run workflow** button.

## What this does not do

The workflow intentionally disables code signing. Apple still requires Xcode on
a physical Mac, an Apple ID team, and a connected iPhone to sign and install the
app for personal use. The build check lets us find and fix compiler problems
before that final Mac session.
