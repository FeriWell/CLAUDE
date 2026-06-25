---
name: config_sudoers_nopasswd
description: Sudoers configuration for passwordless commands on this PC
metadata: 
  node_type: memory
  type: user
  originSessionId: 047112a8-8dd3-4539-99b9-7101b130c2ab
---

## Sudoers NOPASSWD Configuration

**Setup Command:**
```bash
sudo visudo
```

**Add to end of /etc/sudoers file:**
```sudoers
# Allow passwordless apt/package management
%sudo ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /usr/bin/apt-cache

# Allow passwordless installation of specific drivers
%sudo ALL=(ALL) NOPASSWD: /usr/bin/systemctl, /usr/sbin/modprobe

# Allow passwordless i2c tools (for numberpad driver)
%sudo ALL=(ALL) NOPASSWD: /usr/sbin/i2cdetect, /usr/sbin/i2cdump, /usr/sbin/i2cset, /usr/sbin/i2cget

# Allow passwordless udev reload
%sudo ALL=(ALL) NOPASSWD: /usr/sbin/udevadm

# Allow passwordless service management for driver
%sudo ALL=(ALL) NOPASSWD: /bin/systemctl, /bin/systemctl enable, /bin/systemctl start, /bin/systemctl stop, /bin/systemctl restart
```

**Safe commands after configuration:**
- `sudo apt install -y i2c-tools`
- `sudo systemctl restart asus-numberpad`
- `sudo i2cdetect -l`
- `sudo udevadm reload`

**Security Note:** These commands are generally safe for system tools. User-restricted to sudo group only.
