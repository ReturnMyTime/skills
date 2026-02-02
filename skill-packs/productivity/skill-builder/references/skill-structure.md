# Skill Structure Reference

Complete documentation of the skill directory structure and requirements.

---

## Required Files

### SKILL.md

Every skill must have a `SKILL.md` file at its root. This is the main file that agents read.

**Frontmatter (YAML):**

```yaml
---
name: skill-name                    # Required: lowercase, hyphenated
description: |                      # Required: >50 chars, actionable
  Clear description of what the skill does and when to use it.
  Include trigger phrases the agent should recognize.
version: 1.0.0                      # Required: semantic versioning
platforms:                          # Required: supported platforms
  - claude
  - claude-code
  - openclaw
  - codex
tier: free | pro | skool            # Required: distribution tier
category: productivity              # Required: see categories below
requires: []                        # Optional: external dependencies
env: []                             # Optional: required env variables
argument-hint: "[args]"             # Optional: usage hint for agents
---
```

**Body Sections:**

1. **Title** (`# Skill Name`) - Human-readable name
2. **Overview** - 2-3 sentence description + keywords
3. **Prerequisites** - What's needed to use this skill
4. **How to Use** - Step-by-step workflow
5. **Examples** - At least one complete example
6. **Guidelines** - Best practices and tips
7. **Troubleshooting** - Common issues and solutions
8. **Version History** - Changelog

---

## Optional Directories

### references/

Supporting documentation the agent can reference during execution.

```
references/
├── architecture.md      # System design docs
├── api-reference.md     # API documentation
├── examples.md          # Additional examples
└── best-practices.md    # Guidelines and patterns
```

### templates/

Output templates for consistent formatting.

```
templates/
├── output-template.md   # Default output format
├── report-template.md   # Report format
└── email-template.md    # Email format
```

### scripts/

Executable tools (UV Python or Go).

```
scripts/
├── tool-name.py         # UV Python script
├── tool-name.go         # Go binary
└── helper.sh            # Shell helper
```

### user/

User personalization files (gitignored).

```
user/
├── .gitignore           # Excludes context.md, config.json, .env
├── context.md.template  # Template for user context
└── config.json.template # Template for user config
```

---

## Categories

Valid categories for the `category` field:

| Category | Description |
|----------|-------------|
| `productivity` | General productivity and workflow skills |
| `coding` | Development, planning, and engineering skills |
| `email` | Email composition and management |
| `content` | Content creation and repurposing |
| `research` | Research and analysis skills |
| `client` | Client management and communication |
| `sales` | Sales and outreach skills |
| `automation` | Workflow automation and integration |
| `brand` | Branding and personal brand skills |
| `launch` | Product and campaign launch skills |

---

## Platforms

Valid platforms for the `platforms` field:

- `claude` - Claude.ai web interface (Projects)
- `claude-code` - Claude Code CLI
- `openclaw` - OpenClaw/Clawdbot
- `codex` - OpenAI Codex CLI

Most skills should support all four platforms unless they have specific dependencies.

---

## Tier Definitions

| Tier | Distribution | Price |
|------|--------------|-------|
| `free` | Public repo, CLI install | $0 |
| `pro` | Paid download (zip) | $47-97 |
| `skool` | Skool membership | Subscription |

---

## Example Complete Structure

```
skill-packs/productivity/my-skill/
├── SKILL.md                    # Main skill file
├── references/
│   ├── workflow-guide.md       # Detailed workflow docs
│   └── integration-notes.md    # Integration details
├── templates/
│   └── output-template.md      # Output format
├── scripts/
│   └── my-tool.py              # UV Python tool
└── user/
    ├── .gitignore
    └── context.md.template
```

---

## Validation Checklist

Before committing a new skill:

- [ ] `SKILL.md` exists with valid frontmatter
- [ ] `name` is lowercase, hyphenated, 2-4 words
- [ ] `description` is >50 characters and actionable
- [ ] `version` follows semver (X.Y.Z)
- [ ] `category` is a valid category
- [ ] At least one example is included
- [ ] `user/.gitignore` excludes `context.md` if `user/` exists
- [ ] Run `./scripts/validate-skill.sh` passes
