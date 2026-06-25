---
name: project_numberpad_driver_installed
description: ASUS NumberPad driver installation status and setup for X3400 VivoBook
metadata: 
  node_type: memory
  type: project
  originSessionId: 047112a8-8dd3-4539-99b9-7101b130c2ab
---

## ASUS NumberPad Driver Installation - X3400 VivoBook

**Status:** ✅ Installed (pending reboot activation)

**Installation Date:** 2026-06-10

**System:** 
- Models: ASUS VivoBook Pro X3400KA and X3400PA
- Kernel: 6.17.0-35-generic
- Display Server: X11
- Dependencies: All installed (Python 3.12.3, libinput, udev, i2c-tools)

**Installation Method:**
```bash
cd /tmp/asus-numberpad-driver
bash install.sh
```

**Post-Installation:**
- System reboot required for driver activation
- NumberPad will activate via tap-and-hold gesture (default 1 second)
- Backlight control available (8 levels)
- Features: Gesture activation, auto-disable on inactivity

**Next Steps:**
1. Reboot system: `sudo reboot`
2. After reboot, NumberPad should be active
3. Test with tap-and-hold on touchpad corner

**Support:** https://github.com/asus-linux-drivers/asus-numberpad-driver
