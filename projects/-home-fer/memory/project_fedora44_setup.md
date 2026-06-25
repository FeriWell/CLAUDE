---
name: project-fedora44-setup
description: "Fedora 44 KDE migration + full system config done 2026-06-16 (drivers, perf, snapshots, audio, VPN, Android). LOAD when working on this PC's system config."
metadata:
  node_type: memory
  type: project
  originSessionId: 70dc4f4f-c3a2-45a5-b4d8-1a68f961c45c
---

# X3400PA — Fedora 44 KDE setup state (configured 2026-06-16)

This PC was **migrated from Linux Mint 22.3 → Fedora 44 KDE Plasma** (kernel 7.0.12, btrfs). Restored via the `claude-hotswap` SD-card package. **CLAUDE.md and several memories still describe the old Mint setup — Fedora is ground truth.** Profile: [[user_system_profile]].

## Drivers / hardware
- **GPU video decode:** swapped Fedora's codec-limited `libva-intel-media-driver` → full **`intel-media-driver`** (RPM Fusion nonfree). Now H.264/HEVC/AV1 HW decode+encode (vainfo: 55 profiles). `vainfo` = `libva-utils`.
- **All other drivers correct out-of-box** (i915, iwlwifi AX201, snd_hda_intel ALC294, nvme, uvcvideo, rtsx_usb, thunderbolt). Firmware all current (fwupd; ASUS not on LVFS).
- **`asusctl`** installed (lukenukem/asus-linux COPR) + `asusd` running — gives battery charge limit + throttle policy. **Fan-curve NOT supported** by X3400PA hardware (no WMI interface — confirmed). Fan RPM is readable via `lm_sensors` (`asus-isa-0000`).
- **lm_sensors** installed (CPU/fan/NVMe temps).
- **Intel GNA accelerator (00:08.0):** NO usable Linux driver — akmod from `xanderlent/intel-gna-driver` does NOT compile on kernel 7.0 (DRM API breaks), and nothing on Linux uses GNA anyway. Don't pursue.

## NumberPad (asus-numberpad-driver)
- Installed from github asus-linux-drivers; layout **`up5401ea`** (X3400PA touchpad `04F3:31BC`).
- Runs as a **system service** `/etc/systemd/system/asus-numberpad.service` using `setpriv --reuid fer --groups input,i2c,uinput,numberpad,wheel` (the upstream `--user` service crashed because the login session lacked the input/i2c/uinput groups). System+setpriv avoids that and survives reboots.

## Performance tweaks applied (all persistent)
- `vm.swappiness=150` (`/etc/sysctl.d/99-zram-swappiness.conf`) — zram is fast, prefer it over dropping cache.
- **zram = zstd** (`/etc/systemd/zram-generator.conf`) — ~51% better ratio than default lzo-rle.
- **noatime** on `/` and `/home` (fstab; backup `/etc/fstab.claude-bak`).
- `vm.dirty_ratio=10`, `vm.dirty_background_ratio=5` (`/etc/sysctl.d/99-ssd-writeback.conf`) — smoother writeback on 8GB+SSD.
- I/O scheduler left at `none` (optimal for NVMe — do NOT change to deadline/bfq).
- **Boot fixes:** disabled `NetworkManager-wait-online.service` (saved ~3.9s, no network mounts) + GRUB_TIMEOUT 5→1 (backup `/etc/default/grub.claude-bak`). Boot ~15s → ~9s.
- CPU governor `performance` (intel_pstate); removed broken Mint-era `cpu-performance.service`/`power-auto-switch` (called nonexistent `powerprofilesctl`; Fedora uses tuned-ppd).

## Snapshots (restore points)
- **snapper + Btrfs Assistant** (Qt GUI) — **manual only**: `TIMELINE_CREATE=no`, `NUMBER_CLEANUP=no`, timers disabled. No dnf auto-snapshot plugin.
- Baseline snapshot **"Default"** (snapshot #1, permanent/no-cleanup) exists for config `root`.
- Timeshift was tried then fully removed (its BTRFS mode needs `@`/`@home`; Fedora uses `root`/`home`).
- Create: `sudo snapper -c root create --description "..."`; GUI: `btrfs-assistant`.

## Audio extras
- **EasyEffects** (Qt build 8.2.4) installed for system EQ/DSP = the Linux way to get the "Harman Kardon" sound (no HK driver exists; ALC294 drives speakers directly, no smart-amp). Autostart at `~/.config/autostart/easyeffects-service.desktop` (`easyeffects --hide-window`). EQ applied via GUI (Qt preset format differs from GTK JSON).

## VPN
- **iWell2 OpenVPN** profile (`~/Documents/iWell2.ovpn`) imported into NetworkManager (cert-only auth, server `35.163.218.63:1194` TCP). Connect: `nmcli connection up iWell2` / down to disconnect, or KDE tray. Verified: tun0 `10.8.0.x`, reaches ws.iwell.solutions + ws.iwell.info.

## Android — see [[reference_android_testing_linux]] (already updated for Fedora)
- Temurin 21 JDK (`/usr/lib/jvm/temurin-21`), dnf `android-tools`, manual SDK `~/Android/Sdk` (platforms/build-tools 34/35/36), udev uaccess for ROG Phone.
- **Android 11 (API 30) emulator** `Android11_API30` created (KVM ready) — **apps' minSdk=30, so they CANNOT run on Android 10**; API 30 is the floor.
- PUMPER + REPORTS cloned to `~/iwell/android` (release branches, local.properties written). gh logged in as FeriWell.

Related: [[user_system_profile]], [[reference_android_testing_linux]], [[project-numberpad-driver-installed]]
