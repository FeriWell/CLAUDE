---
name: project_reports_app_test_2026_06_15
description: "Reports app login test result — 2026-06-15, device ROG Phone 5, PASS"
metadata: 
  node_type: memory
  type: project
  originSessionId: 283d33c2-e130-446e-97fc-145a29bacfdb
---

# Reports App Login Test — 2026-06-15

**Result: PASS**

## App Info
- Package: `info.iwell.reports`
- Version: 3.9.2 (versionCode 79)
- Build: DEBUG (DEBUGGABLE flag)
- Device: ASUS ROG Phone 5 (M3AIKN07P018ZV3), Android 13

## Test Flow
1. App launched → SplashActivity → LoginActivity ✅
2. Credentials: `support@iwell.info` / `D3s1gn10!!` (non-prod debug)
3. Login attempt 1 failed: **network error** — device had airplane mode ON but WiFi connected
4. Airplane mode disabled → retry → **login succeeded** ✅
5. Onboarding screen shown (VideosActivity) → user tapped through
6. Final screen: `WellGroupListActivity` — live well list loaded with production data ✅

## Final Screen
Well Group List showing 14+ wells with Daily Production and Avg Production columns, data dated 06/15/2026. Bottom nav: Edit / Settings / Accounts / Support.

## Notes
- Airplane mode on device caused network error on first login attempt — disable before testing
- Debug build connects to non-prod Cognito / `ws.iwell.solutions`
- `adb shell input text` with single quotes correctly handles `!!` in password

**Why:** QA mobile team routine test pass verification.
**How to apply:** When testing Reports app login, ensure airplane mode is OFF on device first.
