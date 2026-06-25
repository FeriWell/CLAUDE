---
name: feedback-no-scanning
description: Never re-scan system hardware/software — all machine facts are in system_x3400pa_complete.md
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7217a642-64c5-4768-b164-2ad5ce0041e3
---

Never run system audit commands (lscpu, free, df, lsmod, dnf list, java -version, etc.) to re-discover facts already in memory.

**Why:** User explicitly rejected these scans — all system info is permanently captured in [[system-x3400pa-complete]]. Re-scanning wastes time and interrupts the user.

**How to apply:** When any task touches system config, Android toolchain, hardware, or installed tools — READ [[system-x3400pa-complete]] first. Only run a live check if the memory explicitly flags something as uncertain or if the user says "check current state."
