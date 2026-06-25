---
name: user_autoload_default_state
description: AUTO-LOAD DEFAULT — load all PC info and all user info every session by default
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c777f1c6-8d88-4618-ac68-df8c09d43fcd
---

**DEFAULT STATE — AUTO LOAD.** At the start of every session, treat the following as the default context to load and keep current, without being asked:

1. **This PC** — hardware (ASUS VivoBook Pro X3400PA), OS (Linux Mint 22.3, kernel 7.0.0-14), installed tools, admin/sudo access. See [[user_admin_access]], [[user_asus_vivobook_x3400]].
2. **All user info** — GitHub identity **FeriWell**, org **iwell-systems**.
3. **Default repos** — the QA Mobile Team list. See [[project_qa_mobile_team_repos]].
4. **Active projects** — see [[project_linux_optimization]] and all `project_*` memory files.

**Why:** User explicitly asked to save "LOAD ALL information from this PC and ALL MY information" as a default auto-load state so it doesn't have to be re-typed each session.

**How to apply:** Consider this list loaded by default at session start. When the user says "load my info" / "load everything", use this without re-asking. Refresh the underlying memory files when facts change.
