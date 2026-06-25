---
name: project_power_profiles_setup
description: Power mode selector (Performance/Balanced/Power Saver) setup on this PC
metadata: 
  node_type: memory
  type: project
  originSessionId: c777f1c6-8d88-4618-ac68-df8c09d43fcd
---

Power mode selection on this PC (Linux Mint Cinnamon, see [[user_system_profile]]).

**Fixed 2026-06-11:** The Performance / Balanced / Power Saver selector was missing because `power-profiles-daemon` was not installed. Installed v0.21 and enabled it:
```
sudo apt install -y power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon
```

**Result:** Three profiles available via `intel_pstate` + `platform_profile`:
- `performance`, `balanced` (default), `power-saver`

**Usage:**
- GUI: click battery icon in panel (applet `power@cinnamon.org`, already in panel1:right) → pick mode
- CLI: `powerprofilesctl list` / `powerprofilesctl set performance` / `powerprofilesctl get`

**How to apply:** Power management on this machine is handled by power-profiles-daemon (NOT TLP — they conflict). If the applet ever stops showing modes, verify the daemon is running and restart Cinnamon (Ctrl+Alt+Esc).
