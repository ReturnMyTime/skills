---
name: atomic-implementation-plan
description: Generate comprehensive implementation plans with atomic task-level detail, quality gates, and phased execution. Use for any development task that needs thorough planning before implementation.
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
argument-hint: "[feature or objective description]"
---

# Atomic Implementation Plan

Generate a comprehensive, phased implementation plan with atomic task-level detail.

## Workflow

### Phase 1: Research
Thoroughly explore the codebase to understand:
- Existing patterns and architecture
- Related files and dependencies
- Current implementation approaches
- Test patterns in use

Use `rg`/`rg --files` plus `ls`/`cat` to explore before planning.

### Phase 2: Interview (Clarifying Questions)
Ask the user clarifying questions in an interview-style format:
- What is the desired end state?
- Are there any constraints or requirements?
- What existing patterns should be followed?
- What are the success criteria?
- Any edge cases to consider?

Ask the user directly in chat to gather this information.

### Phase 3: Generate Plan
Create a phased implementation plan with:

1. **Atomic Tasks** - Break down to the smallest actionable units
   - Each task should be completable in one focused session
   - Tasks should be verifiable (you can tell when it's done)
   - No task should require context from later tasks

2. **Quality Gates** - Verification steps between phases
   - Tests pass
   - Build succeeds
   - Manual verification steps

3. **SDLC Considerations**
   - Code changes
   - Test coverage
   - Documentation updates

4. **Deployment Considerations**
   - Environment variables
   - Database migrations
   - Configuration changes

### Phase 4: Iteration
Present the plan and accept corrections:
- Listen for missing requirements
- Adjust task ordering if needed
- Add/remove tasks based on feedback
- Refine until approved

### Phase 5: Output
Write the final plan to a markdown file.

---

## Output Format

Write the plan to: `docs/plans/[feature-name]-implementation-plan.md`

Use this structure:

```markdown
# Implementation Plan: [Feature Name]

## Overview
[1-2 sentence description of what we're implementing and why]

## Prerequisites
- [ ] Prerequisite 1
- [ ] Prerequisite 2

## Phase 1: [Phase Name]

### Objective
[What this phase accomplishes]

### Tasks
- [ ] Atomic task with specific file/location
- [ ] Atomic task with specific file/location
- [ ] Atomic task with specific file/location

### Quality Gate
- [ ] Verification step (e.g., "tests pass", "build succeeds")

## Phase 2: [Phase Name]
...

## Deployment

### Environment Changes
- [ ] Environment variable: `VAR_NAME` - [purpose]

### Database/Migration
- [ ] Migration: [description]

### Configuration
- [ ] Config change: [description]

## Verification Checklist
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Manual QA verification: [specific steps]
- [ ] Code review completed

## Rollback Plan
[How to revert if issues are discovered]

## Notes
[Any additional context, decisions made, or alternatives considered]
```

---

## Key Principles

1. **Quality over speed** - Take time to research thoroughly
2. **Atomic granularity** - Each task should be the smallest completable unit
3. **Verifiable outcomes** - Every task should have a clear "done" state
4. **Phased execution** - Group related tasks, verify between phases
5. **No assumptions** - Ask questions when requirements are unclear

---

## Example Usage

User: `/atomic-implementation-plan add Stripe subscription billing`

Response flow:
1. Research existing payment code, models, API routes
2. Ask: "What subscription tiers? Monthly/yearly? Free trial?"
3. Generate phased plan with atomic tasks
4. Iterate based on feedback
5. Write final plan to `docs/plans/stripe-subscription-implementation-plan.md`
