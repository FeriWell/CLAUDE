#!/bin/bash
# Audio Optimization Auto-Monitor for X3400PA
# Runs post-reboot verification

LOG_FILE=~/audio-optimization-verification.log
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "╔════════════════════════════════════════════════════════════╗" | tee $LOG_FILE
echo "║  X3400PA Audio Optimization - Post-Reboot Verification    ║" | tee -a $LOG_FILE
echo "║  Started: $TIMESTAMP" | tee -a $LOG_FILE
echo "╚════════════════════════════════════════════════════════════╝" | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 1. Codec Power State ===" | tee -a $LOG_FILE
cat /proc/asound/card0/codec0 2>/dev/null | grep -A 5 "Power:" | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 2. Codec Reconfiguration Loops ===" | tee -a $LOG_FILE
RECONFIG_COUNT=$(dmesg | grep "reconfiguring" | wc -l)
echo "Reconfiguration attempts: $RECONFIG_COUNT (target: 0-1)" | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 3. Audio Devices (PipeWire) ===" | tee -a $LOG_FILE
pactl list sinks short | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 4. Recording Devices ===" | tee -a $LOG_FILE
pactl list sources short | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 5. ALSA Card Status ===" | tee -a $LOG_FILE
cat /proc/asound/cards | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 6. Firmware Status ===" | tee -a $LOG_FILE
dmesg | grep "Firmware: ABI" | tail -1 | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "=== 7. Audio Errors/Warnings ===" | tee -a $LOG_FILE
ERROR_COUNT=$(dmesg | grep -i "error\|fail" | grep -i "audio\|alsa\|sof" | wc -l)
echo "Audio-related errors: $ERROR_COUNT" | tee -a $LOG_FILE
if [ $ERROR_COUNT -gt 0 ]; then
  dmesg | grep -i "error\|fail" | grep -i "audio\|alsa\|sof" | tee -a $LOG_FILE
fi

echo "" | tee -a $LOG_FILE
echo "=== Verification Complete ===" | tee -a $LOG_FILE
echo "Full log saved to: $LOG_FILE" | tee -a $LOG_FILE

