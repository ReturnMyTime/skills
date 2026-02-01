---
name: agentmd
description: Create a concise AGENTS.md in the current project root by copying the standard template from /Users/nick/Projects/agent-scripts-template/AGENTS_NICK.MD. Use when asked to initialize a project with AGENTS.md or add the default AGENTS.md template.
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: coding
requires: []
env: []
---

# Agentmd

## Overview

Create the project's AGENTS.md by copying the standard template from /Users/nick/Projects/agent-scripts-template/AGENTS_NICK.MD into the current project root as AGENTS.md.

## Workflow

1. Confirm the current working directory is the project root (use `pwd` and/or user-provided `cwd`).
2. Verify the template file exists at `/Users/nick/Projects/agent-scripts-template/AGENTS_NICK.MD`.
3. Check whether `AGENTS.md` already exists in the project root.
   - If it exists, ask before overwriting unless the user explicitly requested a replace.
4. Copy the template:
   - `cp /Users/nick/Projects/agent-scripts-template/AGENTS_NICK.MD ./AGENTS.md`
5. Confirm the file was created and is non-empty (e.g., `ls -l AGENTS.md` or `wc -l AGENTS.md`).

## Notes

Do not edit the contents after copying unless the user asks. Keep the filename exactly `AGENTS.md` in the project root.
