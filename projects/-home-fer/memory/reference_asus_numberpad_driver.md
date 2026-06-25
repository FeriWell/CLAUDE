---
name: reference_asus_numberpad_driver
description: ASUS NumberPad Driver GitHub repo and complete documentation
metadata: 
  node_type: memory
  type: reference
  originSessionId: 047112a8-8dd3-4539-99b9-7101b130c2ab
---

## ASUS NumberPad Driver Repository

**GitHub:** https://github.com/asus-linux-drivers/asus-numberpad-driver

**What it does:** Enables illuminated numeric keypad on ASUS laptops touchpad, with gesture activation, backlight control, and customizable layouts.

**System Requirements:**
- Linux kernel with I2C and input device support
- X11 or Wayland display server
- Python 3
- i2c-tools, libinput, udev dependencies

**Installation Command:**
```bash
git clone https://github.com/asus-linux-drivers/asus-numberpad-driver
cd asus-numberpad-driver
bash install.sh
```

**Supported Models:** 95+ ASUS models including ZenBook, ROG Strix, and VivoBook series

**Documentation Available:**
- README.md (features, installation, configuration)
- CHANGELOG.md (v7.0.0 and older)
- Installation guide (standard and immutable systems)
- Configuration reference
- Troubleshooting and FAQ
- Complete hardware database (400+ touchpad variants)

**Known Issues:**
- Auto-disable timeout capped at ~2 minutes (hardware limitation)
- Some keyboard layouts may not auto-detect correctly
- X11 with invalid MIT-MAGIC-COOKIE-1 errors: remove ~/.Xauthority
- NumberPad disabled when touchpad is system-wide disabled
