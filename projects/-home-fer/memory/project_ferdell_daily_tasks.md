---
name: project-ferdell-daily-tasks
description: "FERDELL PC (Windows C:\\Users\\Fer) — daily tasks, active PRs, iWell priority plan. LOAD for any iWell Android work."
metadata: 
  node_type: memory
  type: project
  originSessionId: 4266affd-50b0-44d6-9886-e30706c68142
---

# FERDELL PC — Daily Tasks & Active Work

**Source:** FeriWell/claude-memory-sync → projects/C--Users-Fer/memory/
**Last synced from GitHub:** 2026-06-19

---

## ❌ CANCELLED ROUTINE — DO NOT RUN

**"Apply FERDELL Portable Configuration Daily"** — PERMANENTLY CANCELLED
- Was: run daily config scripts across platforms (apply_ferdell_config.ps1 / apply_ferdell_config.sh)
- Status: **STOPPED — never run automatically again**
- Why: user explicitly cancelled on 2026-06-19

---

## 🎯 iWell Daily Priority Plan

**Focus:** Android Pumper, Android Reports, iOS Pumper, iOS Reports
**Open Issues:** 23 | **Open PRs:** 11
**Last Updated:** 2026-05-20

### 🔴 CRITICAL (blocks releases)

1. **Update Authentication Method — Cognito** (4 repos)
   - Android Pumper #9, Android Reports #21, iOS Pumper #16, iOS Reports #18
   - Blocks all app deployments

2. **PHP 8.3 Backend Compatibility** (3 tasks)
   - Android Pumper #38, iOS Pumper #40, iOS Reports #30
   - Android Reports: still unverified

### 🟠 HIGH (crashes / data loss)

3. **Android Reports #44** — DB migration crash on upgrade (wrong table name in migration v10)

4. **Firebase SDK → SPM migration** (iOS only)
   - iOS Pumper #32, iOS Reports #27

### 🟡 MEDIUM

5. **Cognito Token + Camera API** — Reports #1, #13, iOS Reports #23
6. **Android API 35 Compatibility** — Pumper #21, #22, Reports #19
7. **Data/Sync Bugs (6)** — Pumper #20, #23, #24, #25, #35, #36

---

## ✅ Active PRs — Ready for Merge (blocked by manual gate only)

### PR #39 — iwell-pumper-android v7.0.0
- Branch: release/7.0.0 → main
- Issues: #9 (Cognito), #21 (edge-to-edge), #23 (sync badge), #45 (sync POST)
- Status: GREEN — evidence, tests, Cognito login all passing
- Blocker: Manual Sprint Merge Gate (Store release approval + Release dependency)
- Repo: `C:\Users\Fer\AppData\Local\Temp\iwell-pumper-android\`
- Creds: support@iwell.info / D3s1gn10!!
- Cognito: us-west-2 / us-west-2_m6WHKJFKQ / 4eao5evqkuc19sj304k89ojg1d
- URL: https://ws.iwell.solutions

### PR #52 — iwell-reports-android v4.0.0
- Branch: release/4.0.0 → main
- Issue: #21 (Cognito auth)
- Status: GREEN — Android screenshots retaken (original iOS screenshots replaced), evidence passing
- Blocker: Manual Sprint Merge Gate
- Repo: `C:\Users\Fer\StudioProjects\iwell-reports-android\`
- Same Cognito config + creds as PR #39

---

## Key Notes (lessons learned on FERDELL)

- `local.properties` MUST be at Windows path, not `/tmp/` Linux path — Gradle can't read it otherwise
- `local_url=https://ws.iwell.solutions` — MUST include `https://` prefix
- Use `keyevent 61` (TAB) between form fields — never tap password field by coordinates
- Screenshots must be Android (not iOS) for Android repos; resize to 720px wide before upload
- GitHub CDN upload via clipboard paste (PowerShell SetImage → Ctrl+V in browser)
- `--rerun-tasks` flag forces BuildConfig regeneration when Cognito values come out empty

**How to apply:** Load this when working on any iWell Android PR, build, or test session.
