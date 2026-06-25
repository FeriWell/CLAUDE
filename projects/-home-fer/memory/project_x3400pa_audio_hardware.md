---
name: x3400pa_audio_hardware_spec
description: ASUS VivoBook Pro 14 OLED (X3400PA) audio hardware specifications and device info
metadata: 
  node_type: memory
  type: project
  originSessionId: 303ad280-490f-4e3e-b7a6-4292f4ea4dc8
---

## ASUS VivoBook Pro 14 OLED (X3400PA) Audio Hardware Specifications

**System Information:**
- Model: ASUS VivoBook Pro 14 OLED X3400PA
- OS: Linux Mint 22.3 (zena)
- Kernel: 7.0.0-14-generic
- Architecture: Intel 11th Gen (Tiger Lake-LP)

**Audio Hardware:**
- **Audio Chipset:** Intel Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
- **PCI Address:** 00:1f.3
- **Audio Codec:** Realtek ALC294 (Vendor ID: 0x10ec0294)
- **HDMI Audio Codec:** Intel Tigerlake HDMI (Vendor ID: 0x80862812)
- **ALSA Card ID:** sofhdadsp (Sound Open Firmware HDA DSP)

**Microphone/Input:**
- Mic Jack: 0x12 (Internal)

**Audio Output:**
- Headphone Jack Support
- HDMI/DP Audio Output (3x HDMI/DP PCM channels: pcm=3, pcm=4, pcm=5)

**ALSA Version:** k7.0.0-14-generic

---

## Current Audio Server Configuration

**Active Audio Server:** PipeWire (primary)
- `/usr/bin/pipewire` - Main server (1 instance)
- `/usr/bin/pipewire -c filter-chain.conf` - Filter chain config (1 instance)
- `/usr/bin/pipewire-pulse` - PulseAudio compatibility layer
- `/usr/bin/pulseeffects` - Effects daemon (running with service flag)

**Status:** No standalone PulseAudio service running (replaced by PipeWire)

---

## Installed Audio-Related Packages

### Core ALSA Components:
- alsa-base (driver configuration)
- alsa-firmware-loaders (1.2.11-1build2)
- alsa-tools-gui
- alsa-topology-conf
- alsa-ucm-conf (1.2.10-1ubuntu5.11)
- alsa-utils (1.2.9-1ubuntu5)
- libasound2-data, libasound2-dev, libasound2t64

### Audio Servers & Plugins:
- **firmware-sof-signed** (2023.12.1-1ubuntu1.11) - Intel SOF firmware
- gstreamer1.0-pipewire (1.0.5-1ubuntu3.2)
- gstreamer1.0-alsa (1.24.2-1ubuntu0.4)
- gstreamer1.0-pulseaudio (transitional package)
- libcanberra-pulse

### Audio Effects & Enhancement:
- easyeffects (7.1.6-1ubuntu0.24.04.1)
- calf-plugins (0.90.3-4build2)
- Various GStreamer effect plugins

### Audio Libraries:
- libao-common and libao4 (Cross Platform Audio Output)
- Various codec libraries
- libavcodec-extra60

---

## Kernel Audio Modules Loaded

**Core SOF (Sound Open Firmware) Stack:**
- snd_sof (421.8 KB)
- snd_sof_pci (Intel PCI support)
- snd_sof_intel_hda* (HDA-specific support)
- snd_sof_xtensa_dsp (DSP support)

**HDA/Audio Codecs:**
- snd_hda_codec_alc269 (Realtek ALC269 - 147.5 KB)
- snd_hda_codec_hdmi (HDMI support)
- snd_hda_codec_generic
- snd_hda_codec_intelhdmi

**SoundWire/SDCA:**
- soundwire_intel (SoundWire host)
- soundwire_bus
- snd_soc_sdw_utils

**PCM/Audio Core:**
- snd_pcm (204.8 KB)
- snd_hda_core (151.6 KB)
- snd_hda_codec (204.8 KB)

**All major modules are loaded and functional**
