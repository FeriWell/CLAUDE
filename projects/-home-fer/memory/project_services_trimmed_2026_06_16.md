---
name: project-services-trimmed-2026-06-16
description: "Fedora 44 systemd services disabled to free RAM; diagnosis that RAM (8GB) is the real bottleneck, not internet"
metadata: 
  node_type: memory
  type: project
  originSessionId: ce65e211-7ab3-4926-b488-dc55dda12985
---

2026-06-16 system audit on X3400PA (Fedora 44 KDE). User asked to "speed up internet / find bottleneck."

**Finding:** Internet is excellent (Wi-Fi 6, -55dBm, ~222 Mbit/s real download, 6ms DNS). NOT the bottleneck. The real bottleneck is **physical RAM: only 8GB (7.4Gi usable)** — was 211MB free, swapping 1.5GB to zram. CPU (performance governor), NVMe (none sched), zram (zstd 5.7x) all already well-tuned. True fix = add a RAM stick (laptop is upgradeable).

**Services disabled (permanent, masked where noted) to free RAM:**
- Bare-metal dead weight: qemu-guest-agent, vboxservice, vgauthd, vmtoolsd, iscsi-onboot, iscsi-starter, mdmonitor, lvm2-monitor (confirmed virt=none, no RAID/LVM/iSCSI)
- Unused by user: switcheroo-control, gssproxy (masked), abrtd+abrt-*, ModemManager, cups(+sockets), avahi-daemon, sssd, atd, passim
- User-level RAM wins: kde-baloo + plasma-baloorunner (masked, Indexing-Enabled=false), akonadi_control (masked)

**Result:** RAM available 2.5GB → 3.7GB (+1.2GB freed), free 211MB → 1.7GB, running services ~50 → 40.

**Left ON intentionally:** bluetooth (user didn't confirm unused). Reversal: `sudo systemctl enable --now cups cups.socket avahi-daemon` for printing; `systemctl --user unmask kde-baloo plasma-baloorunner && balooctl6 enable` for file search.

**Logging stripped down (user: "I don't need logs at all"):** rsyslog disabled+masked; auditd disabled+masked + `auditctl -e 0` + kernel cmdline `audit=0` via grubby (permanent); also disabled livesys/livesys-late (live-USB leftovers). journald CANNOT be disabled (load-bearing) so set to Storage=volatile (RAM-only, 48M cap, no persistent disk logs) via /etc/systemd/journald.conf.d/99-minimal.conf; /var/log/journal cleared (was 40M). To restore logging: delete that drop-in + `grubby --remove-args="audit=0"` + unmask rsyslog/auditd.

**Faster shutdown:** root cause = systemd default 90s/2min stop timeout + fwupd & systemd-homed allowing 3min, user@ 1min. Fixed via drop-ins: /etc/systemd/system.conf.d/99-fast-shutdown.conf and user.conf.d (DefaultTimeoutStopSec/AbortSec/DeviceTimeoutSec=8s) + per-service overrides for fwupd, systemd-homed, user@.service (TimeoutStopSec=8s). Now any hung service is SIGKILLed after 8s instead of 90s+. NM-wait-online already disabled. journald=volatile also skips journal-flush on shutdown.

**Still recommended, not yet done:** install earlyoom (prevents full-RAM freeze; systemd-oomd is active but earlyoom more aggressive for desktop). Related: [[project_zram_swap_tuning]] [[user_system_profile]]
