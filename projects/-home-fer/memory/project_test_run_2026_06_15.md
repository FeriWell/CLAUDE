---
name: project_test_run_2026_06_15
description: "Full QA test run 2026-06-15 — Reports + Pumper login tests on ROG Phone 5, both PASS"
metadata: 
  node_type: memory
  type: project
  originSessionId: 283d33c2-e130-446e-97fc-145a29bacfdb
---

# QA Test Run — 2026-06-15

**Tester:** Claude Code (automated via adb)
**Device:** ASUS ROG Phone 5 (I005DA), Android 13, serial `M3AIKN07P018ZV3`
**Date:** 2026-06-15
**Overall Result:** ✅ ALL PASS

---

## Pre-Flight Checks

| Check | Result |
|-------|--------|
| Device connected (`adb devices`) | ✅ `M3AIKN07P018ZV3 device` |
| Airplane mode OFF | ✅ `settings get global airplane_mode_on` = `0` |
| WiFi connected | ✅ Bunker-5G, VALIDATED, 1200Mbps |
| Both packages installed | ✅ `info.iwell.reports`, `info.iwell.pumper` |

---

## Test 1 — iWell Reports Login

**Package:** `info.iwell.reports`
**Version:** 3.9.2 (versionCode 79)
**Build:** DEBUG (DEBUGGABLE)
**Credentials:** `support@iwell.info` / `D3s1gn10!!`

### Steps
1. `adb shell am force-stop info.iwell.reports`
2. `adb shell monkey -p info.iwell.reports -c android.intent.category.LAUNCHER 1`
3. Waited for LoginActivity to appear ✅
4. Tapped Email field → `adb shell input tap 540 1488`
5. `adb shell input text 'support@iwell.info'`
6. `adb shell input keyevent KEYCODE_TAB` → moved to Password field
7. `adb shell input text 'D3s1gn10!!'` (single quotes — prevents `!!` bash expansion)
8. `adb shell input keyevent KEYCODE_BACK` → dismissed keyboard
9. `adb shell input tap 540 1795` → tapped Login button
10. Waited 8s for Cognito auth
11. App navigated to VideosActivity (onboarding) → then WellGroupListActivity ✅

### Issues Encountered
- **Attempt 1 failed:** airplane mode was ON → "Login Error: There was a network error" dialog
- **Fix:** `adb shell settings put global airplane_mode_on 0` + broadcast intent
- **Lesson:** Always verify airplane mode = 0 before testing

### Result: ✅ PASS
**Final Activity:** `WellGroupListActivity`
**Screen:** 14+ wells listed with Daily Production + Avg Production columns, data dated 06/15/2026

---

## Test 2 — iWell Pumper Login

**Package:** `info.iwell.pumper`
**Version:** 6.10.2 (versionCode 138)
**Build:** DEBUG (DEBUGGABLE)
**Credentials:** `support@iwell.info` / `D3s1gn10!!`

### Steps
1. `adb shell am force-stop info.iwell.pumper`
2. `adb shell monkey -p info.iwell.pumper -c android.intent.category.LAUNCHER 1`
3. Waited for LoginActivity ✅
4. Tapped Email field → `adb shell input tap 540 1488`
5. `adb shell input text 'support@iwell.info'`
6. `adb shell input keyevent KEYCODE_TAB` → Password field
7. `adb shell input text 'D3s1gn10!!'`
8. `adb shell input keyevent KEYCODE_BACK` → dismissed keyboard
9. Used `adb shell uiautomator dump` to get exact Login button bounds: `[36,2145][1044,2252]`
10. `adb shell input tap 540 2198` → tapped Login button
11. Auth succeeded → VideosActivity (WELCOME screen) appeared ✅
12. Account download progress bar ran (~5 minutes)
13. "START USING IWELL PUMPER" button appeared at bounds `[226,2226][855,2324]`
14. `adb shell input tap 540 2275` → tapped Start button
15. Camera/video permission dialog appeared
16. `adb shell input tap 539 1241` → granted "WHILE USING THE APP"
17. App navigated to WellGroupListActivity ✅

### Result: ✅ PASS
**Final Activity:** `WellGroupListActivity`
**Screen:** Well list with Reported + Synced columns, all wells showing green ✅ checkmarks, data dated 06/15/2026

---

## adb Login Script (reusable)

```bash
ADB=~/Android/Sdk/platform-tools/adb
PKG=$1   # info.iwell.reports OR info.iwell.pumper

# Pre-check
[[ $($ADB shell settings get global airplane_mode_on) == "0" ]] || {
  $ADB shell settings put global airplane_mode_on 0
  $ADB shell am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false
  sleep 2
}

# Launch
$ADB shell am force-stop $PKG && sleep 1
$ADB shell monkey -p $PKG -c android.intent.category.LAUNCHER 1 2>/dev/null
sleep 3

# Fill form
$ADB shell input tap 540 1488; sleep 1
$ADB shell input keyevent KEYCODE_CTRL_A; $ADB shell input keyevent KEYCODE_DEL
$ADB shell input text 'support@iwell.info'; sleep 0.5
$ADB shell input keyevent KEYCODE_TAB; sleep 0.5
$ADB shell input text 'D3s1gn10!!'; sleep 0.5
$ADB shell input keyevent KEYCODE_BACK; sleep 1

# Get exact Login button coords via uiautomator
$ADB shell uiautomator dump /sdcard/ui.xml 2>/dev/null
$ADB pull /sdcard/ui.xml /tmp/ui.xml 2>/dev/null
LOGIN_Y=$(python3 -c "
import xml.etree.ElementTree as ET, re
for n in ET.parse('/tmp/ui.xml').iter():
    if n.get('text','').lower()=='login' and n.get('clickable')=='true':
        b = n.get('bounds','')
        coords = list(map(int, re.findall(r'\d+', b)))
        print((coords[1]+coords[3])//2)
" 2>/dev/null)
$ADB shell input tap 540 ${LOGIN_Y:-2198}
sleep 8

# Result
$ADB shell dumpsys activity activities | grep topResumedActivity
$ADB exec-out screencap -p > /tmp/${PKG##*.}_result.png
```

---

## Summary

| App | Version | Build | Login | Final Screen | Status |
|-----|---------|-------|-------|--------------|--------|
| Reports | 3.9.2 (79) | DEBUG | ✅ | WellGroupListActivity | ✅ PASS |
| Pumper | 6.10.2 (138) | DEBUG | ✅ | WellGroupListActivity | ✅ PASS |

**Why:** Routine QA mobile team login verification before sprint release review.
**How to apply:** Run same script before any PR merge approval for Reports or Pumper.
