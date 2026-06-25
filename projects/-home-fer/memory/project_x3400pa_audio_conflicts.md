---
name: x3400pa_audio_conflicts_identified
description: Critical conflicts and issues found in X3400PA audio driver configuration
metadata: 
  node_type: memory
  type: project
  originSessionId: 303ad280-490f-4e3e-b7a6-4292f4ea4dc8
---

## CRITICAL CONFLICT #1: SOF Firmware ABI Mismatch

**Severity:** HIGH - Core functionality risk

**Details:**
```
Firmware ABI: 3:22:1
Kernel ABI: 3:23:1
```

**Issue:** Firmware version (2023.12.1) is incompatible with kernel version (7.0.0-14)
- Firmware built for an older kernel ABI version
- Kernel has newer ABI that firmware doesn't support

**Impact:**
- May cause audio dropout
- Potential codec initialization failures
- Codec power state issues (documented in dmesg)

**Current Status in dmesg:**
```
sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:1
```

---

## CRITICAL CONFLICT #2: HDA Codec Power State Management Failure

**Severity:** HIGH - Direct audio functionality issue

**Details:** AFG (Audio Function Group) node error
```
State of AFG node 0x01:
  Power: setting=UNKNOWN, actual=UNKNOWN, Error, Clock-stop-OK, Setting-reset
  Invalid AFG subtree
```

**Codec Affected:** Realtek ALC294 (ehdaudio0D0)

**Impact:**
- Codec cannot properly manage power states
- May cause hardware not responding errors
- Contributes to recurring codec reconfiguration attempts

**Evidence in dmesg (recurring every ~2 minutes):**
```
snd_hda_codec_alc269 ehdaudio0D0: hda-codec: reconfiguring
snd_hda_codec_alc269 ehdaudio0D0: The codec is being used, can't reconfigure.
```

Pattern shows 11+ reconfiguration attempts in dmesg (timestamps 12656-13886 seconds)

---

## CRITICAL CONFLICT #3: HDMI/DP PCM Configuration Mismatch

**Severity:** MEDIUM - HDMI audio output issue

**Details:**
```
hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
```

**Issue:**
- SOF firmware topology doesn't define PCM for HDMI converter 3
- HDMI output channels exist (pcm=3, pcm=4, pcm=5) but incomplete topology mapping

**Impact:**
- HDMI audio output may not work or be misconfigured
- Some HDMI/DP outputs may not be available

---

## CONFLICT #4: PulseAudio Compatibility Layer Overhead

**Severity:** MEDIUM - Performance/Compatibility

**Details:**
- PipeWire is running full PulseAudio compatibility layer
- `/usr/bin/pipewire-pulse` actively translating calls
- Older GStreamer plugin still installed: `gstreamer1.0-pulseaudio`

**Issue:**
- Double translation layer (apps → PA compat → PipeWire)
- Adds latency and CPU overhead
- Transitional package (should be removed)

**Impact:**
- Unnecessary processing overhead
- Potential for feature gaps in compatibility layer
- Confusing configuration landscape

---

## CONFLICT #5: Ineffective HDA Jack Retask Attempts

**Severity:** LOW-MEDIUM - Jack detection issue

**Details:**
```
root 16415: /bin/sh /tmp/hda-jack-retask-XE3FQ3/script.sh
```

Background process attempting to reconfigure jack pinouts but:
- Script executed but producing no visible output
- No indication of success or failure
- May be conflicting with SOF firmware management

**Issue:**
- HDA Jack Retask tool (legacy) may not work with SOF firmware
- Configuration may be overwritten by SOF topology

---

## SUMMARY OF CONFLICTS

| Conflict | Type | Impact | Priority |
|----------|------|--------|----------|
| SOF ABI Mismatch | Firmware/Kernel | Codec stability, audio dropout | **CRITICAL** |
| HDA Power State | Codec Control | Reconfiguration loops, failures | **CRITICAL** |
| HDMI PCM Topology | HDMI Audio | No/broken HDMI output | **HIGH** |
| PulseAudio Compat | Performance | Latency, overhead, confusion | **MEDIUM** |
| HDA Jack Retask | Config Conflict | Jack detection issues | **LOW** |

**Conclusion:** Audio hardware is present and mostly functional, but SOF firmware ABI mismatch with the kernel is the root cause of stability issues and codec power management failures. This needs immediate attention.
