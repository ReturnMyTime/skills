---
name: transcript-to-sop
description: Convert meeting/session transcripts into clean, actionable SOPs with sensitive data automatically redacted. Great for turning pair programming sessions into documentation.
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: automation
requires: []
env: []
argument-hint: "[path to transcript file]"
---

# Transcript to SOP

Convert a meeting or session transcript into a clean, shareable Standard Operating Procedure.

## Workflow

### Step 1: Read the Transcript
Read the provided transcript file or accept pasted content.

### Step 2: Identify & Redact Sensitive Data
Scan for and replace sensitive information with placeholders:

| Pattern | Replacement |
|---------|-------------|
| `sk_live_*`, `sk_test_*` | `[STRIPE_SECRET_KEY]` |
| `pk_live_*`, `pk_test_*` | `[STRIPE_PUBLISHABLE_KEY]` |
| `whsec_*` | `[STRIPE_WEBHOOK_SECRET]` |
| API keys (long alphanumeric strings) | `[API_KEY]` |
| Passwords mentioned | `[PASSWORD]` |
| `.env` file values | `[ENV_VALUE]` |
| Internal URLs (*.internal.*, staging.*) | `[INTERNAL_URL]` |
| IP addresses | `[IP_ADDRESS]` |
| Database connection strings | `[DATABASE_URL]` |
| AWS keys (`AKIA*`) | `[AWS_ACCESS_KEY]` |
| JWT tokens | `[JWT_TOKEN]` |
| Personal phone numbers | `[PHONE]` |
| Email addresses (optional, ask user) | `[EMAIL]` |

### Step 3: Extract Key Information
From the transcript, identify:

1. **Main Procedures** - Step-by-step workflows performed
2. **Tools & Technologies** - Software, services, and platforms used
3. **Commands Run** - Terminal commands, scripts executed
4. **Decisions Made** - Choices and their rationale
5. **Action Items** - Tasks mentioned for follow-up
6. **Troubleshooting** - Problems encountered and solutions

### Step 4: Structure as SOP
Organize extracted information into a clean SOP format.

### Step 5: Output
Write the SOP to a markdown file.

---

## Output Format

Write the SOP to: `docs/sops/[process-name]-sop.md`

If no `docs/sops` directory exists, ask user for preferred location.

Use this structure:

```markdown
# SOP: [Process Name]

> Generated from session transcript on [date]

## Overview
[2-3 sentences describing what this procedure accomplishes]

## Prerequisites

### Tools Required
- [Tool 1] - [what it's used for]
- [Tool 2] - [what it's used for]

### Access Required
- [System/service] - [level of access needed]

### Knowledge Required
- [Concept or skill needed]

---

## Procedure

### Step 1: [Step Name]
[Clear description of what to do]

```bash
# Commands to run (if applicable)
command --flag value
```

**Expected outcome:** [What you should see/have after this step]

### Step 2: [Step Name]
[Description]

...continue for all steps...

---

## Key Decisions

| Decision | Rationale | Alternatives Considered |
|----------|-----------|------------------------|
| [Choice made] | [Why this was chosen] | [Other options] |

---

## Troubleshooting

### Issue: [Problem description]
**Symptom:** [What you see]
**Solution:** [How to fix it]

---

## Action Items
- [ ] [Follow-up task from session]
- [ ] [Another task]

---

## Related Resources
- [Link or reference]
- [Documentation URL]

---

## Session Metadata
- **Date:** [Session date]
- **Participants:** [Names, if appropriate to include]
- **Duration:** [Approximate length]
- **Recording:** [Link if available, or "N/A"]
```

---

## Sensitive Data Handling

**Before writing the SOP, show the user:**
1. List of sensitive items detected
2. The placeholder replacements proposed
3. Ask for confirmation before proceeding

Example:
```
Detected sensitive data:
- 3 Stripe keys → [STRIPE_*_KEY]
- 2 internal URLs → [INTERNAL_URL]
- 1 database connection string → [DATABASE_URL]

Proceed with these redactions? (y/n)
```

---

## Example Usage

User: `/transcript-to-sop ~/development_transcript.txt`

Response flow:
1. Read transcript file
2. Detect: "Found 5 API keys, 2 internal URLs, 3 passwords"
3. Show redaction plan
4. Extract procedures: "Main workflow: Stripe integration setup"
5. Structure as SOP
6. Write to `docs/sops/stripe-integration-setup-sop.md`
7. Provide summary: "Created SOP with 8 steps, 3 decisions documented, 4 action items captured"

---

## Tips for Best Results

- Longer transcripts produce better SOPs (more context)
- Transcripts from Fathom, Otter.ai, or similar tools work well
- Session recordings with timestamps help identify sequence
- Ask the user if any sections should be excluded
