---
name: feedback-daily-report-scope
description: Daily report must include exactly 4 repos: Android Pumper, Android Reports, iOS Pumper, iOS Reports — no others
metadata:
  node_type: memory
  type: feedback
  originSessionId: daily-2026-06-25
---

## PERMANENT DEFAULT — "daily" command always runs ALL 4 repos

When the user types `daily`, run `gh pr list` on ALL 4 repos and show full open PR table grouped by repo:

1. `iwell-systems/iwell-pumper-android`
2. `iwell-systems/iwell-reports-android`
3. `iwell-systems/iwell-pumper-ios`
4. `iwell-systems/iwell-reports-ios`

**Why:** User confirmed 2026-06-25 — "Save this on daily command INCLUDE ALL permanently." All 4 repos are always included, no exceptions, no need to ask.

**How to apply:**
- `daily` typed alone = immediately fetch all 4 repos in parallel, show full PR tables
- Do NOT include other repos (Swift rewrite, Jetpack Compose, lib-ios-foundation, etc.) unless explicitly asked
- Load [[project_fedora44_setup]], [[project-ferdell-daily-tasks]], [[project_update_manager_fix]] as context alongside the PR data
