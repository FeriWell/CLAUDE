---
name: project-zram-swap-tuning
description: zram compressed swap + swappiness tuning applied on X3400PA (7.5GB RAM bottleneck)
metadata: 
  node_type: memory
  type: project
  originSessionId: a2cffe4a-3192-4a61-9b17-dd6a89e25e6a
---

The X3400PA's real performance bottleneck is RAM (7.5 GB, was actively disk-swapping). Fixed 2026-06-14 with zram.

**Applied:**
- Installed `zram-tools`; `/etc/default/zramswap` set to `ALGO=zstd`, `PERCENT=50` (~3.7 GB), `PRIORITY=100`. `zramswap.service` enabled.
- `/etc/sysctl.d/60-zram-swappiness.conf`: `vm.swappiness=10`, `vm.vfs_cache_pressure=75` (were 60/100).
- Result: zram0 (prio 100) is used before the 2 GB disk `/swapfile` (prio -1).

**Note:** Earlier memory [[project-cpu-ssd-optimization]] claimed a permanent performance CPU governor, but on 2026-06-14 the system was actually on `powersave` governor + `power-saver` profile — that optimization was not active. NVMe scheduler `none` and weekly fstrim ARE still active/optimal.

**Undo:** `sudo systemctl disable --now zramswap.service` + delete the sysctl.d file.
