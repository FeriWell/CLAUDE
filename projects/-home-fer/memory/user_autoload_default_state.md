---
name: user_autoload_default_state
description: AUTO-LOAD DEFAULT — load all PC info and all user info every session by default
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7217a642-64c5-4768-b164-2ad5ce0041e3
---

**DEFAULT STATE — AUTO LOAD EVERY SESSION.** Load the following at session start without being asked:

1. **[[system-x3400pa-complete]]** — the ONE complete fact sheet for this machine. Contains ALL hardware, OS, toolchain, Android setup, credentials, gotchas, Claude config. NEVER re-scan — read this instead.
2. **GitHub identity:** FeriWell, org iwell-systems
3. **Default repos:** QA Mobile Team (Android Pumper, Android Reports, iOS Pumper, iOS Reports). See [[project_qa_mobile_team_repos]].
4. **Rules always active:** bypassPermissions ON, no interruptions, local rules only, remote reads auto-permitted, settings files immutable (chattr +i).
5. **Android daily reference:** [[reference_android_testing_linux]] — build commands, adb login script, gotchas, credentials.

**Why:** User explicitly requires all machine and user info loaded every session with zero re-scanning or re-asking.

**How to apply:** On ANY session start, treat system_x3400pa_complete.md as loaded ground truth. Never ask about the system, never scan it, never re-discover it.
