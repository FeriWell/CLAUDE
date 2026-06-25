---
name: system-x3400pa-complete
description: PERMANENT COMPLETE SYSTEM FACT SHEET — X3400PA Fedora 44. Never re-scan. Load instead of scanning.
metadata: 
  node_type: memory
  type: user
  originSessionId: 7217a642-64c5-4768-b164-2ad5ce0041e3
---

# PERMANENT SYSTEM FACT SHEET — ASUS VivoBook Pro X3400PA
> Last verified: 2026-06-25. NEVER re-scan this machine — use this file as ground truth.

## Hardware (fixed — never changes)
- **CPU:** Intel Core i5-11300H (Tiger Lake) — 4 cores / 8 threads, 3.1–4.4GHz, L2 5MiB, L3 8MiB
- **RAM:** 8GB DDR4-3200 (2×4GB SO-DIMM, NOT soldered — upgradeable to 128GB). Real bottleneck.
- **Disk:** Kingston NVMe 238.5GB (`nvme0n1`), DRAM-less, btrfs root, ~226GB free, I/O scheduler `none`
- **GPU:** Intel Iris Xe (Tiger Lake GT2) — VA-API 55 profiles via `intel-media-driver` (RPM Fusion nonfree)
- **Wi-Fi:** Intel Wi-Fi 6 AX201 — ~222 Mbit/s, NOT the bottleneck
- **Audio:** Realtek ALC294 (HDA path, works fine on Fedora — no SOF issues)
- **NumberPad:** asus-numberpad-driver installed, layout `up5401ea`, system service `asus-numberpad.service`

## OS / Software (Fedora 44 KDE — migrated from Mint 2026-06-16)
- **OS:** Fedora Linux 44, KDE Plasma / Wayland, kernel 7.0.12-201.fc44.x86_64
- **Filesystem:** btrfs (subvols root/home, zstd:1, noatime)
- **Pkg manager:** `dnf` — NOT apt. RPM Fusion free+nonfree enabled.
- **Shell:** bash. Claude Code 2.1.179.

## Performance Config (ALL applied — do not re-apply)
- **CPU:** intel_pstate driver; power-profiles-daemon + tuned-ppd manage EPP. DO NOT force `scaling_governor=performance` — breaks EPP switching. Auto-switch: AC=performance, battery=power-saver via udev + `cpu-performance.service`.
- **RAM/Swap:** zram zstd ~3.7GB prio 100, swappiness=150 (Fedora config), vm.dirty_ratio=10/5. earlyoom: ⚠️ RECOMMENDED but NOT YET INSTALLED.
- **NVMe:** scheduler=none (optimal), fstrim.timer weekly.
- **Boot:** NetworkManager-wait-online disabled, GRUB timeout 1s. Boot ~9s.
- **Logging:** rsyslog+auditd disabled/masked, journald volatile 48M RAM-only, audit=0 kernel cmdline.
- **Shutdown:** DefaultTimeoutStopSec=8s everywhere.
- **Services trimmed:** qemu-guest-agent, vboxservice, cups, avahi, baloo, akonadi, ModemManager, sssd, abrtd, passim, switcheroo disabled/masked. Freed +1.2GB RAM.
- **Snapshots:** snapper (manual only), baseline "Default" snapshot #1 exists.
- **EasyEffects** autostart for KDE system EQ (Harman Kardon sound via DSP).

## Android Toolchain (DO NOT REINSTALL — already set up 2026-06-16)
- **Java:** Temurin JDK 21 at `/usr/lib/jvm/temurin-21` (tarball install — Fedora has no java-21 package)
- **Android SDK:** `~/Android/Sdk` (cmdline-tools/latest, platform-tools, platforms 34/35/36, build-tools 34/35/36)
- **adb:** 1.0.41 (dnf android-tools + SDK platform-tools 37.0.0)
- **KVM:** active — kvm_intel loaded, `/dev/kvm` present, fer in kvm group
- **Emulator AVD:** `Android11_API30` (minSdk=30, apps need API 30+)
- **udev:** `/etc/udev/rules.d/51-android.rules` — ROG Phone 5 (0b05) + Google (18d1), uaccess auto-grant
- **Projects:** `~/iwell/android/PUMPER/iwell-pumper-android` (release/7.0.0) + `~/iwell/android/REPORTS/iwell-reports-android` (release/4.0.0)
- **GitHub:** logged in as FeriWell, gh auth setup-git done

## Env vars (in ~/.bashrc — permanent)
```bash
export JAVA_HOME=/usr/lib/jvm/temurin-21
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/34.0.0:$JAVA_HOME/bin:$PATH"
```

## CLI Tools (ALL installed)
node v20.20.2, npm 10.8.2, jq 1.7, bat 0.24.0, ripgrep/rg, fd, fzf, tree, shellcheck, git-delta, shfmt, gh 2.94, python3, gcc, make, curl, wget, lm_sensors, intel-media-driver, vainfo

## Claude Code Config
- settings.json + settings.local.json: `chattr +i` (immutable — unlock with `sudo chattr -i` to edit, re-lock after)
- defaultMode: bypassPermissions, outputStyle: Proactive, model: sonnet, effortLevel: high
- Stop hook: auto-syncs ~/.claude → FeriWell/CLAUDE on every session end
- GitHub MCP server: dynamic token via `$(gh auth token)` — safe to commit
- All MCP tools allowlisted: Bash(*), Read(*), Edit(*), mcp__claude-in-chrome__*, mcp__claude_ai_Linear__*, mcp__claude_ai_Slack__*, mcp__github__*

## Physical Test Device
- **ASUS ROG Phone 5 (I005DA)**, Android 13 (API 33), serial M3AIKN07P018ZV3, screen 1080x2448
- Packages: `info.iwell.pumper` / `info.iwell.reports`
- Connect: USB-C, accept debug prompt, adb devices shows `device`

## iWell Test Credentials
- Non-prod (debug): `support@iwell.info` / `D3s1gn10!!`
- Production (release): `support@iwell.info` / `D3s1gn10$`
- Cognito: region=us-west-2, pool=us-west-2_m6WHKJFKQ, client=4eao5evqkuc19sj304k89ojg1d
- local_url: `https://ws.iwell.solutions` (MUST include https://)

## local.properties (write to each repo root before building)
```
sdk.dir=/home/fer/Android/Sdk
aws_cognito_region=us-west-2
aws_user_pool_id=us-west-2_m6WHKJFKQ
aws_app_client_id=4eao5evqkuc19sj304k89ojg1d
local_url=https://ws.iwell.solutions
```

## Known Gotchas (NEVER forget)
1. Temurin 21 only — Fedora java-25 breaks AGP/Gradle
2. `local_url` MUST have `https://` prefix
3. BuildConfig empty → add `--rerun-tasks`
4. Airplane mode blocks Cognito even on WiFi → check `adb shell settings get global airplane_mode_on` = 0
5. Password `D3s1gn10!!` → use SINGLE quotes in bash (!! = history expansion)
6. Keyboard shifts tap coords — fill email → TAB → fill password → KEYCODE_BACK → tap Login
7. DO NOT force scaling_governor=performance on intel_pstate — breaks EPP/power-profiles-daemon

## Additional Tools Installed 2026-06-25
- **earlyoom 1.9.0** — active, prevents full-RAM freeze during builds (`systemctl is-active earlyoom` → active)
- **scrcpy v4.0** — at `~/.local/bin/scrcpy` (binary release, SDL3); use to mirror ROG Phone screen
- **uiautomator2 3.6.0** — pip3 user install; better Python UI automation than raw adb
- **igt-gpu-tools / intel_gpu_top** — GPU usage monitor for Iris Xe during emulator
- **~/.gradle/gradle.properties** — daemon+parallel+caching+G1GC 2GB heap, 4 workers
- **~/.android/advancedFeatures.ini** — GLDirectMem+Vulkan ON for Iris Xe hardware rendering
- **ANDROID_EMULATOR_USE_SYSTEM_LIBS=1** — in ~/.bashrc, uses system GL for emulator
- **GitHub MCP server** — in settings.json, uses `$(gh auth token)` dynamically. Allowlisted: `mcp__github__*`
- **DO NOT install:** gh copilot extension (user rejected)
