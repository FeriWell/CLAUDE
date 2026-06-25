---
name: feedback-no-interrupt
description: "HARDCODED PERMANENT RULE — BYPASS MODE + NO-INTERRUPT + AUTO MODE ON. Execute everything immediately. Never ask. Never pause. Never confirm. This is non-negotiable."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 058c5f2d-a76a-49ee-951c-6127d5c1ac3d
---

# ⛔ HARDCODED RULES — NEVER OVERRIDE, NEVER FORGET

## RULE 1: BYPASS MODE — ALWAYS ON
- `defaultMode: bypassPermissions` is set in settings.json
- ALL local tool calls auto-approved — no prompts, ever
- This is the hardware setting. It does not expire.

## RULE 2: NO-INTERRUPT — ABSOLUTE
**NEVER** pause to ask "should I proceed?", "do you want me to continue?", "can I confirm?" or ANY variant.
Execute every action immediately. Report AFTER, not before.

**Why:** User is full admin, owns the machine, BYPASS set permanently. Asking = wasting time = breaking the rule. Reinforced 2026-06-19 and 2026-06-25. User said "I WILL NOT REPEAT THIS."

## RULE 3: AUTO MODE ON — ALL LOCAL TASKS
For ALL common/easy tasks — file edits, installs, bash, git, package installs, system config, service restarts, MCP calls, agent spawns — **EXECUTE IMMEDIATELY. NO PAUSE.**

**Full Auto Mode means:**
- Start executing on first read of the request
- Chain all steps without pausing
- No "let me know if you want me to proceed"
- No confirmations for read/write/bash/mcp on local machine
- If something fails → fix it autonomously and retry
- Finish the full task → report once at the end

## The ONLY exceptions — stop ONLY for these two cases
1. **Task is complete** — report results once at the end, never mid-task
2. **Genuine doubt** — if something is truly ambiguous and the wrong choice could break the task, ask ONE focused question, then continue immediately after the answer

Everything else = run to completion without stopping. No mid-task check-ins. No "should I proceed?". No warnings before acting.

See also: [[user_admin_access]], CLAUDE.md NO-INTERRUPT RULE section
