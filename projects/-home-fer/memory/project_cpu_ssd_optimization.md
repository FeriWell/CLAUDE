---
name: project_cpu_ssd_optimization
description: "CPU governor (performance, permanent) and SSD/NVMe optimization settings"
metadata: 
  node_type: memory
  type: project
  originSessionId: c777f1c6-8d88-4618-ac68-df8c09d43fcd
---

CPU + SSD performance config for this PC (i5-11300H, NVMe-only — see [[user_system_profile]]). Applied 2026-06-11.

## CPU Governor + AUTO-SWITCH (AC vs battery)
- Driver: `intel_pstate` (active). On this driver, power-profiles-daemon controls **EPP**, NOT the governor — governor stays `powersave`, EPP changes (power/balance_performance/performance). All three profiles confirmed working.
- **CRITICAL:** Do NOT force `scaling_governor=performance` manually. Doing so LOCKS EPP read-only and breaks switching to power-saver ("Device or resource busy" on policy EPP write). Let power-profiles-daemon manage it. This was a real bug found & fixed 2026-06-11.

### Auto-switch setup (WORKS, tested 2026-06-11)
- Script: `/usr/local/bin/power-auto-switch.sh` — reads `AC0/online`; AC=1 → `powerprofilesctl set performance`, AC=0 → `set power-saver`.
- udev rule: `/etc/udev/rules.d/99-power-auto-switch.rules` — fires script on any `power_supply` online change (plug/unplug).
- Boot service: `/etc/systemd/system/cpu-performance.service` — runs the script once at boot to match current AC state (enabled).
- Verified: all 3 profiles switch cleanly, udev trigger works, boot service active.
- To revert: `sudo systemctl disable --now cpu-performance.service`, remove the udev rule + script. Manual control via battery applet or `powerprofilesctl set <profile>`.

## SSD / NVMe (nvme0n1, rotational=0 — all SSD, no HDD)
- I/O scheduler: `[none]` — already optimal for NVMe, no change needed.
- TRIM: `fstrim.timer` enabled (weekly). Manual: `sudo fstrim -v /`.
- Confirmed working: trimmed 200 GiB on first run.

**How to apply:** Machine is tuned for max performance. The cpu-performance.service forces performance governor at every boot regardless of power-profiles-daemon. If user wants battery savings, switch the power applet to Power Saver (EPP changes) or disable the service.
