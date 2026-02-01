---
name: prime
description: Gain a quick, general understanding of a repository. Use when a user asks to prime, onboard, or get a high-level read of the codebase; run a minimal discovery pass and report a short summary.
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

# Prime

## Overview

Execute the Run, Read, and Report steps to build a quick mental model of the repo.

## Run

Run `git ls-files` from the repository root to list tracked files.

## Read

Read `README.md`. If it is missing, state that explicitly in the report.

## Report

Summarize your understanding of the codebase:
- What the project is and what it does.
- The main directories or modules.
- How to run, test, or develop (if documented).

Keep the summary brief and concrete.
