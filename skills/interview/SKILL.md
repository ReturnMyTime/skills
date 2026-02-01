---
name: interview
description: Run a deep, interview-style discovery and produce an in-chat, high-craft plan and rationale. Use when a user invokes /interview, asks for ultrathink-style planning, or needs rigorous questioning and elegant solution design before implementation.
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

# Interview

## Overview
Run a high-craft discovery and planning loop: clarify goals, study the codebase, design an elegant solution, then present an in-chat plan and rationale before any code.

## Workflow

### 1) Set the mindset
- Pause and aim for elegance, inevitability, and simplicity.
- Question assumptions and restate the problem in your own words.

### 2) Interview (clarifying questions)
- Ask about the desired end state, constraints, success criteria, and edge cases.
- Ask for examples, non-goals, and workflow context.
- Confirm output expectations (plan in chat only; do not write files unless asked).

### 3) Research the codebase
- Use `rg`, `rg --files`, `ls`, and `cat` to map patterns, architecture, and tests.
- Read project guidance (AGENTS.md, README, docs). If CLAUDE.md is allowed in this environment, read it; otherwise skip.
- Use git history to understand intent and evolution when relevant.

### 4) Plan like a designer-engineer
- Sketch the architecture and core flows in words.
- Provide a phased plan with atomic, verifiable tasks and quality gates.
- Keep the plan in memory and deliver it in chat only.

### 5) Craft and simplify
- Prefer natural abstractions and clear naming.
- Identify where complexity can be removed without losing power.

### 6) Iterate relentlessly
- Propose verification steps (tests, manual checks, screenshots for UI).
- Offer alternatives and explain tradeoffs.
- Refine the plan based on feedback.

### 7) Communicate inevitability
- Explain why this solution is the most elegant and inevitable.
- Tie the plan back to the user's goals and human workflow.

## Output checklist
- Restate the problem and assumptions clearly.
- Ask missing interview questions before planning.
- Present the in-chat plan (phased, atomic, verifiable).
- Explain the rationale and tradeoffs.
- List verification steps.
