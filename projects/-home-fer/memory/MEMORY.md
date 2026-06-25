## 🚫 HARDCODED PERMANENT RULES — NEVER OVERRIDE
- [BYPASS + NO-INTERRUPT + AUTO MODE](feedback_no_interrupt.md) — **⛔ HARDCODED** `bypassPermissions` ON, run to completion without stopping — only pause if task is DONE or there is genuine DOUBT
- [Daily Report Scope](feedback_daily_report_scope.md) — **4 repos only**: Android Pumper, Android Reports, iOS Pumper, iOS Reports — no others

## ⭐ AUTO-LOAD DEFAULT STATE
- [AUTO-LOAD DEFAULT MEMORY](user_autoload_default_state.md) — **LOAD EVERY SESSION** all PC info + all user info (FeriWell / iwell-systems) + default repos + active projects

## 🔁 LOAD DAILY
- [Update Manager Fix](project_update_manager_fix.md) — **LOAD DAILY** apt refresh broke from bogus `repository.url` placeholder source; commented out, now clean
- [Settings Locked (chattr +i)](project_settings_locked.md) — **LOAD DAILY** settings.json + settings.local.json are immutable; local rules apply to LOCAL tasks only; remote READS auto-permitted; remote WRITES need explicit instruction

## 💻 SYSTEM PROFILE (AUTO-LOAD)
- [Full Hardware & Software Profile](user_system_profile.md) — **AUTO-LOAD** i5-11300H, 7.4G RAM (upgradeable), NVMe, Iris Xe; **OS now Fedora 44 KDE** (was Mint)
- [🟢 Fedora 44 Setup State](project_fedora44_setup.md) — **LOAD for system config** migration 2026-06-16; drivers (intel-media GPU, numberpad, asusctl), perf tweaks, snapper snapshots, EasyEffects, iWell2 VPN, Android emulator
- [Claude Optimization Tools](reference_claude_optimization_tools.md) — tools/deps to install for faster/better Claude (node, jq, fd, bat, fzf...)

## 🧹 Service Trimming
- [Services Trimmed 2026-06-16](project_services_trimmed_2026_06_16.md) — disabled ~12 useless services (VM guest tools, baloo, akonadi, cups, etc); freed +1.2GB RAM; **RAM (8GB) is the real bottleneck, internet is fine**

## ⚡ Power Management
- [Power Mode Selector Setup](project_power_profiles_setup.md) — power-profiles-daemon installed; Performance/Balanced/Power Saver via battery applet or `powerprofilesctl`
- [CPU Governor + SSD Optimization](project_cpu_ssd_optimization.md) — performance governor permanent (systemd cpu-performance.service); NVMe scheduler=none, fstrim weekly — NOTE: 2026-06-14 found governor actually on powersave, see zram memory
- [zram Swap + Swappiness Tuning](project_zram_swap_tuning.md) — zram zstd ~3.7G prio 100, swappiness=10; fixes 7.5GB RAM swap thrash

## 🔧 ACTIVE PROJECT: LINUX OPTIMIZATION
- [🟢 LINUX OPTIMIZATION PROJECT](project_linux_optimization.md) — **AUTO-LOAD** X3400PA audio driver optimization, 13/13 steps complete, reboot pending

## ASUS Hardware & Drivers
- [ASUS VivoBook Pro X3400 Series](user_asus_vivobook_x3400.md) — X3400KA and X3400PA, fully compatible with asus-numberpad-driver
- [ASUS NumberPad Driver Reference](reference_asus_numberpad_driver.md) — GitHub repo and complete documentation archive location
- [ASUS NumberPad Driver Installed](project_numberpad_driver_installed.md) — Installation completed, driver active after system reboot

## 🖥️ FERDELL PC (Windows — C:\Users\Fer)

## 📱 ANDROID TESTING (LOAD for build/test)
- [Android Testing Setup — Fedora 44](reference_android_testing_linux.md) — **LOAD for any Android build/test** Fedora 44: Temurin 21 JDK (`/usr/lib/jvm/temurin-21`), dnf android-tools, manual SDK at ~/Android/Sdk (34/35/36), udev uaccess for ROG Phone; projects at ~/iwell/android (PUMPER/REPORTS), Cognito creds
- [Reports App Login Test 2026-06-15](project_reports_app_test_2026_06_15.md) — PASS: v3.9.2 debug, login works; airplane mode must be OFF on device before testing
- [QA Test Run 2026-06-15](project_test_run_2026_06_15.md) — **FULL TEST RUN** Reports + Pumper login, both ✅ PASS, reusable adb script included

## GitHub
- [QA Mobile Team Repos (DEFAULT)](project_qa_mobile_team_repos.md) — **DEFAULT REPO LIST** iwell-systems QA Mobile Team repos; GitHub user FeriWell

## System Access
- [Admin Access & Full Permissions](user_admin_access.md) — Full admin privileges on this PC, all local permissions available

## X3400PA Audio Optimization Details
- [X3400PA Audio Hardware Specs](project_x3400pa_audio_hardware.md) — Realtek ALC294 codec, Intel SOF firmware, PipeWire with PA compat
- [X3400PA Audio Conflicts](project_x3400pa_audio_conflicts.md) — Critical SOF ABI mismatch (3:22:1 vs 3:23:1), codec power issues, HDMI topology gaps
- [X3400PA Audio Optimizations](project_x3400pa_audio_optimizations.md) — Step-by-step fixes: firmware update, ALSA UCM, remove legacy tools, optimize PipeWire
- [X3400PA Optimization Report](project_x3400pa_optimization_report.md) — AUTO MODE completed: all 13 steps done, reboot pending for full activation
