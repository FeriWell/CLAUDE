---
name: project-settings-locked
description: Claude settings files are immutable (chattr +i); all bypass/no-interrupt rules apply to LOCAL tasks only
metadata: 
  node_type: memory
  type: project
  originSessionId: 7217a642-64c5-4768-b164-2ad5ce0041e3
---

Settings files locked immutable on 2026-06-25:
- `/home/fer/.claude/settings.json` — `chattr +i` applied
- `/home/fer/.claude/settings.local.json` — `chattr +i` applied

**Why:** User wants the bypassPermissions + no-interrupt configuration permanently enforced and uneditable by any process, including root, without explicit user action (`chattr -i` to unlock).

**Scope rule added to CLAUDE.md:** All rules (bypass, no-interrupt, auto-approve) apply **exclusively to LOCAL tasks** — file edits, shell commands, installs, system config. Remote operations (GitHub push, Slack messages, external deploys) still require explicit user instruction.

**How to apply:** If settings ever need updating, run `sudo chattr -i <file>`, edit, then re-lock with `sudo chattr +i <file>`. Never modify these files without user direction.
