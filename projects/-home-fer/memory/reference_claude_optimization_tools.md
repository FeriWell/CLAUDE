---
name: reference_claude_optimization_tools
description: Tools & dependencies that make Claude Code run faster/better on this PC
metadata: 
  node_type: memory
  type: reference
  originSessionId: c777f1c6-8d88-4618-ac68-df8c09d43fcd
---

Tools that optimize Claude Code performance on this machine. Cross-ref [[user_system_profile]].

## Installed (ALL set up — 2026-06-11)
- **ripgrep (rg)** 14.1.1 — fast search (Claude's preferred backend) ✓
- **node** v18.19.1 + **npm** 9.2.0 — MCP servers, JS tooling ✓
- **jq** 1.7 — JSON parsing ✓
- **fd** 9.0.0 (binary `fdfind`, symlinked to `~/.local/bin/fd`) ✓
- **bat** 0.24.0 (binary `batcat`, symlinked to `~/.local/bin/bat`) ✓
- **fzf** 0.44.1, **tree** 2.1.1, **shellcheck**, **git-delta** 0.16.5, **shfmt** 3.8.0 ✓
- **git, gh, python3, gcc, make, java 21, curl, wget** ✓

NOTE: `fd`/`bat` are Debian-renamed (`fdfind`/`batcat`); symlinks created in `~/.local/bin`.
node is v18 from apt — if a newer Node is needed later, use nvm.

## Perf notes for this PC
- 8 logical CPUs → safe to run ~6 parallel agents/jobs; leave headroom.
- Only ~3.5 GiB free RAM — avoid many heavy parallel processes; prefer streaming.
- NVMe SSD, 189G free → disk is not a bottleneck.

**How to apply:** When the user wants Claude "faster/better," recommend installing the missing tools above (esp. node+npm and jq). Re-scan with the tool loop in transcript history if unsure what's present.
