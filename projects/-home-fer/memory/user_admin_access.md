---
name: user_admin_access
description: "Full admin + bypass mode permanently configured on this PC — no permission prompts, no trust questions, all local tasks auto-approved"
metadata: 
  node_type: memory
  type: user
  originSessionId: d8178ecf-4ec6-4a30-aff3-9111ef9a5e0a
---

# Admin Access & Permanent Bypass Mode — X3400PA

## Permissions (hardcoded 2026-06-15)
- Full passwordless sudo on this machine
- **`~/.claude/settings.json`** — `defaultMode: bypassPermissions`, all tools allowed via `Bash(*)`, `Read(*)`, `Edit(*)`, `Write(*)`
- **`~/.claude/settings.local.json`** — `defaultMode: bypassPermissions`
- **`~/.bashrc` + `~/.bash_aliases`** — `alias claude="claude --dangerously-skip-permissions"` so every session starts bypassed
- **`~/CLAUDE.md`** — global rule: never ask for permission on local tasks

## Trusted directories
`/home/fer`, `/home/fer/iwell`, `/etc`, `/tmp`

## Rules (apply every session)
- Never prompt for tool approval on local operations
- Never show the "trust this folder?" startup question — home dir is always trusted
- Never ask before installing packages, editing files, or running shell commands
- Full access to all iWell Android repos under `~/iwell/android`
