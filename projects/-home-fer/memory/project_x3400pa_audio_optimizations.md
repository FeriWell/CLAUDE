---
name: x3400pa_audio_optimizations
description: Audio driver optimization and installation improvements for X3400PA
metadata: 
  node_type: memory
  type: project
  originSessionId: 303ad280-490f-4e3e-b7a6-4292f4ea4dc8
---

## AUDIO DRIVER OPTIMIZATIONS FOR X3400PA

### OPTIMIZATION 1: Update SOF Firmware to Match Kernel ABI (CRITICAL)

**Problem:** Firmware ABI 3:22:1 vs Kernel ABI 3:23:1 mismatch

**Solution Option A - Upgrade SOF Firmware:**
```bash
sudo apt update
sudo apt install --only-upgrade firmware-sof-signed
```

**Solution Option B - Downgrade Kernel (If necessary):**
- Current kernel: 7.0.0-14
- May need to test with kernel that matches firmware (usually 6.8.x series for 2023.12.1 firmware)

**Expected Outcome:**
- Eliminates firmware/kernel incompatibility
- Fixes codec power state management
- Reduces dmesg errors and codec reconfiguration attempts
- Improves audio stability

**Verification:**
```bash
dmesg | grep "Firmware: ABI"  # Should show matching ABI versions
cat /proc/asound/card0/codec0  # Power state should be valid
```

---

### OPTIMIZATION 2: Fix HDA Codec Power State Management

**Problem:** AFG node showing "Power: UNKNOWN, Error"

**Solution: Update ALSA UCM Configuration**

1. **Check current configuration:**
```bash
find /usr/share/alsa/ucm -name "*X3400*" -o -name "*X3490*" -o -name "*Vivobook*"
ls /usr/share/alsa/ucm/conf.d/
```

2. **Create/Update UCM config for X3400PA:**
- Use community-maintained ALSA UCM profiles for newer ASUS laptops
- Or create custom profile with proper pin definitions

3. **Or use Intel SOF TPLG topology fixes:**
```bash
sudo alsamixer  # Check if mixer controls are detected
amixer -c 0 -q contents  # Dump mixer settings
```

**Expected Outcome:**
- HDA codec power states properly initialized
- Codec no longer needs forced reconfiguration
- Mic and audio routes properly detected

**Verification:**
```bash
cat /proc/asound/card0/codec0 | grep "Power:"  # Should show valid state
dmesg | grep "reconfiguring"  # Should have zero or minimal entries
```

---

### OPTIMIZATION 3: Fix HDMI/DP Audio Topology

**Problem:** Missing PCM definition for HDMI converter 3

**Solution A - Update SOF Topology Files:**
```bash
# Check current topology
ls -la /lib/firmware/intel/sof*tplg*

# May need:
sudo apt install linux-firmware-alsa  # Or newer SOF firmware package
```

**Solution B - Build Custom Topology (Advanced):**
- Requires SOF SDK
- Define proper HDMI/PCM mappings for Tiger Lake-LP
- Map all 3 HDMI converters (3, 4, 5) to PCM endpoints

**Solution C - Use ALSA UCM fixes:**
```bash
# Update alsa-ucm-conf
sudo apt install --only-upgrade alsa-ucm-conf
```

**Expected Outcome:**
- All 3 HDMI/DP outputs properly configured
- HDMI audio works on all ports
- No topology mismatch warnings in dmesg

**Verification:**
```bash
aplay -l  # Should list all HDMI outputs with proper names
dmesg | grep "no PCM in topology"  # Should be zero
```

---

### OPTIMIZATION 4: Remove Legacy HDA Jack Retask Conflicts

**Problem:** Legacy tool conflicting with SOF firmware management

**Solution:**
```bash
# Remove legacy tools
sudo apt remove --purge hda-jack-retask hdajackretask

# Verify no background scripts running
ps aux | grep hda-jack  # Should return empty
pkill -9 hda-jack-retask  # Force kill if stuck

# Clear any persistent config
rm -rf ~/.config/hda-jack-retask/  2>/dev/null || true
```

**Why:**
- SOF firmware handles jack detection natively
- Legacy tool overrides SOF configuration
- Creates conflicting reconfiguration attempts

**Expected Outcome:**
- No background jack retask processes
- Jack detection handled by SOF topology
- Cleaner dmesg logs

---

### OPTIMIZATION 5: Streamline PipeWire Configuration

**Problem:** Unnecessary PulseAudio compatibility overhead

**Solution A - Remove Transitional Packages:**
```bash
# Remove old PA packages
sudo apt remove gstreamer1.0-pulseaudio
sudo apt purge pulseaudio pulseaudio-module-*  # If fully migrated to PipeWire

# Clean up dependencies
sudo apt autoremove
```

**Solution B - Optimize PipeWire Config:**
```bash
# Copy default configs if not customized
cp /usr/share/pipewire/pipewire.conf ~/.config/pipewire/
cp /usr/share/pipewire/pipewire-pulse.conf ~/.config/pipewire/

# Edit for X3400PA optimization:
# - Reduce resampling quality for lower CPU
# - Disable unused PCM routes
# - Configure HDMI fallback behavior
```

**Solution C - Disable Unnecessary Effects:**
```bash
# PulseEffects is running in service mode but may not be needed
systemctl --user disable easyeffects.service

# Or review what effects are active:
pactl list | grep -A 10 "Sinks:"
```

**Expected Outcome:**
- ~2-3% CPU usage reduction
- Lower audio latency
- Cleaner configuration

**Verification:**
```bash
ps aux | grep pipewire  # Should show only main processes
ps aux | grep pulseeffects  # May be gone or idle
```

---

### OPTIMIZATION 6: Update ALSA Base Configuration

**Problem:** Generic ALSA config may not optimal for X3400PA

**Solution:**
```bash
# Review current config
cat /etc/modprobe.d/alsa-base.conf

# Add X3400PA-specific parameters:
# Create /etc/modprobe.d/alsa-x3400pa.conf with:
options snd_sof_intel_hda_generic model=asus_vivobook
options snd_hda_codec_alc269 model=alc294 
```

**Expected Parameters:**
- `model=asus_vivobook` or similar
- ALC294 force model specification
- Power saving parameters for battery efficiency

**Verification:**
```bash
modinfo snd_hda_codec_alc269 | grep "parm:"
cat /proc/asound/card0/codec0 | head -5
```

---

### OPTIMIZATION 7: Install Latest ALSA Utilities and Dev Tools

**Problem:** May be missing diagnostic and configuration tools

**Solution:**
```bash
# Install comprehensive ALSA toolset
sudo apt install alsa-tools alsa-tools-gui alsamixer alsactl

# For advanced diagnostics
sudo apt install audio-recorder audacity sox

# For configuration
sudo apt install alsaucm-conf
```

**Tools Added:**
- `alsactl` - Save/restore mixer settings
- `alsamixer` - GUI/TUI mixer
- `audio-recorder` - Test audio recording
- `sox` - Audio testing and conversion

---

## RECOMMENDED INSTALLATION ORDER

1. **First:** Update SOF Firmware (fixes critical ABI mismatch)
   ```bash
   sudo apt update && sudo apt upgrade
   ```

2. **Second:** Update ALSA UCM and config
   ```bash
   sudo apt install --only-upgrade alsa-ucm-conf alsa-base
   ```

3. **Third:** Remove conflicting legacy tools
   ```bash
   sudo apt remove hda-jack-retask
   ```

4. **Fourth:** Optimize PipeWire configuration
   ```bash
   # Edit configs as needed
   ```

5. **Fifth:** Install diagnostic tools and test
   ```bash
   sudo apt install alsa-tools alsa-tools-gui alsamixer
   ```

6. **Finally:** Reboot and verify
   ```bash
   sudo reboot
   dmesg | grep -i "audio\|alsa\|sof"
   aplay -l
   arecord -l
   ```

---

## EXPECTED IMPROVEMENTS AFTER OPTIMIZATION

| Issue | Before | After | Improvement |
|-------|--------|-------|-------------|
| Codec reconfiguration loops | 11+ per boot | 0-1 | Eliminates instability |
| HDMI audio output | Not working | All 3 ports work | Enables external speakers |
| HDA power management | Errors | Valid state | Proper sleep/wake |
| CPU usage (audio) | ~5-7% | 2-3% | Better battery life |
| Audio latency | Variable | Stable | Better recording/playback |
| Configuration clarity | Multiple overlays | Single source of truth | Easier maintenance |

---

## TESTING PROCEDURE AFTER INSTALLATION

```bash
# 1. Boot and check firmware
dmesg | grep "Firmware: ABI"

# 2. Verify codec health
cat /proc/asound/card0/codec*

# 3. Test playback
speaker-test -t sine -f 440 -l 5

# 4. Test recording
arecord -d 5 -f cd test.wav && aplay test.wav

# 5. Check HDMI
aplay -l | grep HDMI

# 6. Monitor for errors
watch -n 2 "dmesg | tail -20"
```
