---
name: reference_android_testing_linux
description: "ANDROID DAILY — full Fedora 44 toolchain, build, install, test. LOAD for every Android task. X3400PA (Fedora 44 KDE) + ROG Phone 5 device."
metadata: 
  node_type: memory
  type: reference
  originSessionId: d8178ecf-4ec6-4a30-aff3-9111ef9a5e0a
---

# Android Daily Setup — Fedora 44 KDE (X3400PA) + ROG Phone 5

> **OS migrated Mint → Fedora 44 (kernel 7.0.x) on 2026-06-16.** Toolchain rebuilt with dnf + Temurin. All `apt`/`openjdk-21-jdk-headless` references from the old setup are obsolete — see below.

## ⚠️ Critical gotchas
1. **Fedora 44 has NO `java-21` package** — only `java-25-openjdk` / `java-latest`. Java 25 is too new for the projects' Gradle/AGP and breaks builds. **Use Temurin 21** (Adoptium LTS), installed as a tarball at `/usr/lib/jvm/temurin-21` (symlink → `jdk-21.0.11+10`). It has full `javac`/`jlink`/`jmods`. Reinstall via: `curl -fL "https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jdk/hotspot/normal/eclipse?project=jdk" -o /tmp/j.tgz && sudo tar xzf /tmp/j.tgz -C /usr/lib/jvm && sudo ln -sfn /usr/lib/jvm/jdk-21* /usr/lib/jvm/temurin-21`
2. **SDK is a MANUAL install** (`~/Android/Sdk`) — Fedora's `android-tools` only gives adb/fastboot, not the SDK. cmdline-tools + sdkmanager used for platforms/build-tools. Do NOT expect a distro SDK package.
3. **`local_url` needs `https://`** — `ws.iwell.solutions` alone crashes at runtime: `IllegalArgumentException: Expected URL scheme 'http' or 'https' but no scheme was found`.
4. **BuildConfig empty strings** — if Cognito values are `""` in BuildConfig, Gradle didn't read local.properties. Force regen: `--rerun-tasks`.
5. **Airplane mode blocks Cognito even with WiFi connected** — Cognito auth fails with "network error". Always check: `adb shell settings get global airplane_mode_on` → must be `0`. Disable: `adb shell settings put global airplane_mode_on 0 && adb shell am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false`
6. **`adb shell input text` with `!!` in password** — use SINGLE quotes in bash: `adb shell input text 'D3s1gn10!!'`. Double quotes trigger bash history expansion and corrupt the password.
7. **Keyboard shifts tap coordinates** — when keyboard opens after tapping a field, all coordinates shift up. Strategy: fill email → TAB to password → fill password → `KEYCODE_BACK` to dismiss keyboard → THEN tap Login at full-screen coords.

## Device plug-in readiness (Fedora — set up 2026-06-16)
- **udev:** `/etc/udev/rules.d/51-android.rules` — ROG Phone vendor `0b05` + Google/fastboot `18d1`, `MODE=0660 GROUP=plugdev TAG+="uaccess"`. The `uaccess` tag means the **active session user is auto-granted access on plug — no relogin/reboot needed**.
- **plugdev** group exists, `fer` is a member.
- On plug: accept the USB-debug prompt on the phone (first time), then `adb devices` shows it as `device`.

## Toolchain (Fedora 44 — installed 2026-06-16; do NOT reinstall unless broken)
| Tool | Version / Location | Install |
|------|--------------------|---------|
| Temurin JDK 21 | `/usr/lib/jvm/temurin-21` (javac/jlink/jmods) | Adoptium tarball (see gotcha #1) |
| `adb` | 1.0.41 | dnf `android-tools` (also SDK platform-tools 37.0.0) |
| `fastboot` | 37.0.0 (SDK) / dnf android-tools | |
| Android SDK | `~/Android/Sdk` | manual; cmdline-tools `latest` at `~/Android/Sdk/cmdline-tools/latest` |
| platform-tools | adb/fastboot in `~/Android/Sdk/platform-tools` | sdkmanager |
| platforms | android-34, 35, 36 | sdkmanager |
| build-tools | 34.0.0, 35.0.0, 36.0.0 | sdkmanager |
| `gh` | 2.94 (dnf) — for cloning repos (needs `gh auth login`) | |
| `scrcpy` | NOT in Fedora 44 repos — optional, use `flatpak install flathub org.scrcpy.scrcpy` | |

**Env already in `~/.bashrc`:**
```bash
export JAVA_HOME=/usr/lib/jvm/temurin-21
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/34.0.0:$JAVA_HOME/bin:$PATH"
```

## Physical device
- **ASUS ROG Phone 5 (I005DA)**, Android 13 (SDK 33), serial `M3AIKN07P018ZV3`, screen 1080x2448
- USB debug mode ON; authorized via udev uaccess
- Packages: `info.iwell.pumper`, `info.iwell.reports`

## Projects layout (CLONED 2026-06-16, on correct branches, local.properties written)
```
~/iwell/android/
  PUMPER/iwell-pumper-android        branch: release/7.0.0  (PR #39 v7.0.0)  ✅ cloned
  REPORTS/iwell-reports-android      branch: release/4.0.0  (PR #52 v4.0.0)  ✅ cloned
```
- **Compose repo (`iwell-reports-android-jetpack-compose`) NOT needed** — only the two production apps above.
- GitHub auth: logged in as **FeriWell** (gh token, `repo` scope); `gh auth setup-git` done so git fetch/pull/push work over HTTPS.
- Clone more with: `gh repo clone iwell-systems/<repo> <path>`

## local.properties (write to EACH repo root before building)
```properties
sdk.dir=/home/fer/Android/Sdk
aws_cognito_region=us-west-2
aws_user_pool_id=us-west-2_m6WHKJFKQ
aws_app_client_id=4eao5evqkuc19sj304k89ojg1d
local_url=https://ws.iwell.solutions
```

## Servers
| Build type | BASE_URL | Environment |
|-----------|----------|-------------|
| `release` | `https://ws.iwell.info` | Production |
| `debug` (with local_url set) | `https://ws.iwell.solutions` | Cognito/testing |
| `debug` (no local_url) | `https://ws.iwell-labs.info` | Labs fallback |

## Test credentials
| Environment | Username | Password |
|-------------|----------|----------|
| Non-prod (debug/solutions/labs) | `support@iwell.info` | `D3s1gn10!!` |
| Production (release → ws.iwell.info) | `support@iwell.info` | `D3s1gn10$` |

## Build commands (build BEFORE install, always)
```bash
export JAVA_HOME=/usr/lib/jvm/temurin-21
export ANDROID_HOME="$HOME/Android/Sdk"
cd ~/iwell/android/<REPO>

./gradlew clean assembleDebug -x lint --no-daemon              # standard
./gradlew clean assembleDebug -x lint --no-daemon --rerun-tasks  # force BuildConfig regen
# APK output: app/build/outputs/apk/debug/app-debug.apk
```

## Install & launch on device
```bash
PKG=info.iwell.pumper   # or info.iwell.reports
APK=app/build/outputs/apk/debug/app-debug.apk
adb uninstall $PKG 2>/dev/null || true
adb install -r "$APK"
adb shell monkey -p $PKG -c android.intent.category.LAUNCHER 1
adb logcat -v brief | grep -iE "cognito|login|BASE_URL|error" &
```

## Test login via adb (installed app)
```bash
PKG=info.iwell.reports  # or info.iwell.pumper

# PRE-CHECK: airplane mode must be OFF
adb shell settings get global airplane_mode_on   # must return 0
# If 1: adb shell settings put global airplane_mode_on 0 && adb shell am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false

adb shell am force-stop $PKG; sleep 1
adb shell monkey -p $PKG -c android.intent.category.LAUNCHER 1; sleep 3

# Fill login form — ROG Phone 5 screen is 1080x2448
adb shell input tap 540 1488          # tap Email field
sleep 1
adb shell input keyevent KEYCODE_CTRL_A && adb shell input keyevent KEYCODE_DEL
adb shell input text 'support@iwell.info'; sleep 0.5
adb shell input keyevent KEYCODE_TAB  # move to Password
adb shell input text 'D3s1gn10!!'; sleep 0.5   # single quotes — prevents !! expansion
adb shell input keyevent KEYCODE_BACK # dismiss keyboard
sleep 1
adb shell input tap 540 1795          # tap Login (full-screen coords)
sleep 8

adb exec-out screencap -p > /tmp/login_result.png
adb shell dumpsys activity activities | grep topResumedActivity
```

## UI automation tips
- `adb shell uiautomator dump /sdcard/ui.xml && adb pull /sdcard/ui.xml /tmp/ui.xml`
- Parse: `python3 -c "import xml.etree.ElementTree as ET; [print(n.get('text'), n.get('bounds')) for n in ET.parse('/tmp/ui.xml').iter() if n.get('clickable')=='true']"`
- Error dialogs: look for `text="OK"` in the dump.

## Latest test results (2026-06-15, on prior Mint setup — re-verify on Fedora)
| App | Version | Build | Result | Activity after login |
|-----|---------|-------|--------|----------------------|
| Reports | 3.9.2 (79) | DEBUG | ✅ PASS | WellGroupListActivity — 14+ wells, daily/avg production |
| Pumper | 6.10.2 (138) | DEBUG | ✅ PASS | WellGroupListActivity — Reported/Synced status |

## Pumper post-login notes
- After login: WELCOME screen (VideosActivity) with account download progress (~5 min)
- Progress done → "START USING IWELL PUMPER" at bounds [226,2226][855,2324]
- Tap → camera/video permission dialog → grant "WHILE USING THE APP" (`adb shell input tap 539 1241`)
- Final: WellGroupListActivity; bottom nav Edit / Settings / Accounts / Support

## Active PRs under test
- **Pumper PR #39** → `release/7.0.0` — v7.0.0 Cognito auth overhaul (issues #9 #21 #23 #45)
- **Reports PR #52** → `release/4.0.0` — v4.0.0 Cognito auth (issue #21)
- Both OPEN, approved, **blocked by Sprint Merge Gate — do NOT merge without Store release approval**

## Credentials source of truth
`FeriWell/claude-memory-sync` (PRIVATE): `reference_android_credentials.md`, `reference_test_credentials.md`, `project_pumper_pr39.md`, `project_reports_pr52.md`.
Related: [[project_qa_mobile_team_repos]], [[android-credentials]], [[pumper-pr39-state]], [[project-reports-pr52]]

## Add SDK platform/build-tools
```bash
yes | ~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager "platforms;android-XX" "build-tools;XX.0.0"
```
