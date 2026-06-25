---
name: user_system_profile
description: AUTO-LOAD — full hardware & software profile of this PC (permanent reference)
metadata: 
  node_type: memory
  type: user
  originSessionId: c777f1c6-8d88-4618-ac68-df8c09d43fcd
---

**PERMANENT SYSTEM PROFILE — load every session.** Full hardware + software inventory of this PC. Part of [[user_autoload_default_state]].

## Hardware
- **Machine:** ASUS VivoBook Pro 14 OLED X3400PA
- **CPU:** 11th Gen Intel Core i5-11300H @ 3.10GHz — 4 cores / 8 threads, max 4.4GHz; L2 5MiB, L3 8MiB
- **RAM:** 7.4 GiB total, 2× **4GB DDR4-3200 SO-DIMM (UPGRADEABLE, not soldered; max 128GB)** — biggest perf lever is a RAM upgrade. zram zstd swap.
- **Disk:** Kingston OM8PDP3256B NVMe 238.5 GB (`nvme0n1`), **DRAM-less**; root `/` btrfs 236G ~4% used (~226G free). I/O scheduler `none` (optimal for NVMe).
- **GPU:** Intel Iris Xe Graphics (TigerLake-LP GT2) — full HW video accel via RPM Fusion `intel-media-driver`
- **Wi-Fi:** Intel Wi-Fi 6 AX201
- **Audio:** Realtek ALC294 (HDA path on Fedora, no SOF ABI issue) (see [[project_x3400pa_audio_hardware]])

## Software / OS  — ⚠️ MIGRATED Mint → Fedora 44 on 2026-06-16
- **OS:** **Fedora Linux 44 (KDE Plasma Desktop Edition)** — was Linux Mint 22.3 (now obsolete)
- **Kernel:** 7.0.12-201.fc44.x86_64
- **Desktop:** KDE Plasma (Wayland)
- **Filesystem:** btrfs (subvols `root`, `home`; zstd:1 compression, noatime)
- **Pkg manager:** `dnf` (NOT apt). RPM Fusion free+nonfree enabled. Power: `tuned`+`tuned-ppd`+`thermald`.
- **Shell:** bash; **Claude Code** 2.1.179
- See [[project-fedora44-setup]] for everything configured this session.

## Installed dev tools (✓ present — optimized 2026-06-11)
- git 2.43.0, gh 2.45.0, ripgrep 14.1.1, python3 3.12.3 + pip 24.0,
  java openjdk 21, gcc 13.3.0, make 4.3, curl 8.5.0, wget 1.21.4
- **node v18.19.1, npm 9.2.0, jq 1.7, fd 9.0.0, bat 0.24.0, fzf 0.44.1,
  tree 2.1.1, shellcheck, git-delta 0.16.5, shfmt 3.8.0** (all installed for Claude optimization)

## Still not installed (install only if a task needs them)
- docker, go, rustc
See [[reference_claude_optimization_tools]] for full optimization details.

**How to apply:** Treat this as ground truth for the machine. 8 logical CPUs → workflows/parallel agents can use ~6 concurrent. Low free RAM (~3.5G) — avoid heavy parallel memory loads. Refresh if hardware/OS changes.
