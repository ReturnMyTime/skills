---
name: skill-builder
description: Create new agent skills following repository best practices. Generates complete skill directory structures with SKILL.md, references, and optional single-file tools (UV Python or Go). Use when you need to create a new skill for the ReturnMyTime skills repository.
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: productivity
requires: []
env: []
argument-hint: "[skill-name] [--category <category>] [--with-tool <uv|go>]"
---

# Skill Builder

Create new agent skills following ReturnMyTime repository best practices.

## Overview

A meta skill for generating new skills. Guides you through requirements gathering, validates naming conventions, generates the complete directory structure, and optionally scaffolds single-file tools in UV Python or Go.

**Keywords**: skill, generator, template, meta, productivity

## Prerequisites

- Access to the skills repository (`~/Projects/skills` or cloned repo)
- For `--with-tool uv`: Python 3.11+ and [uv](https://github.com/astral-sh/uv) installed
- For `--with-tool go`: Go 1.21+ installed

## Quick Start

```bash
# Basic skill
/skill-builder my-new-skill --category productivity

# Skill with UV Python tool
/skill-builder data-processor --category automation --with-tool uv

# Skill with Go CLI tool  
/skill-builder api-client --category coding --with-tool go
```

---

## Workflow

### Phase 1: Interview

Gather requirements through questions:

1. **Skill name** - What should the skill be called?
   - Validate: lowercase, hyphenated, 2-4 words max
   - Example: `quick-reply`, `meeting-prep`, `skill-builder`

2. **Description** - What does it do and when should it be used?
   - Should be clear enough for the agent to know when to invoke it
   - Include trigger phrases

3. **Category** - Which category does it belong to?
   - Options: `productivity`, `coding`, `email`, `content`, `research`, `client`, `sales`, `automation`, `brand`, `launch`

4. **Workflow** - What are the main steps?
   - Break into phases or numbered steps
   - Include inputs, processing, outputs

5. **Tool support** - Does it need a CLI tool?
   - `uv`: For Python scripts (quick prototyping, data processing)
   - `go`: For distributable binaries (CLI tools, performance-critical)
   - `none`: Pure prompt-based skill

### Phase 2: Validate

Before generating, check:

- [ ] Name follows conventions (see `references/naming-conventions.md`)
- [ ] Category exists in `skill-packs/`
- [ ] No duplicate skill name
- [ ] Description is actionable (>50 characters)

### Phase 3: Generate Structure

Create the skill directory:

```
skill-packs/<category>/<skill-name>/
├── SKILL.md              # Main skill file (required)
├── references/           # Supporting documentation (optional)
│   └── *.md
├── templates/            # Output templates (optional)
│   └── *.md
├── scripts/              # Tool scripts (if --with-tool)
│   └── <tool>.<py|go>
└── user/                 # Personalization (optional)
    ├── .gitignore
    └── context.md.template
```

### Phase 4: Generate SKILL.md

Use the template from `templates/SKILL-TEMPLATE.md`:

```yaml
---
name: <skill-name>
description: <description from interview>
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free
category: <category>
requires: []
env: []
argument-hint: "<usage hint>"
---
```

Fill in sections:
- Overview
- Prerequisites
- How to Use (workflow steps)
- Examples
- Guidelines
- Troubleshooting
- Version History

### Phase 5: Generate Tool (if requested)

**For `--with-tool uv`:**

Create `scripts/<skill-name>.py` from `templates/uv-script.py.template`:
- Self-contained single file
- Uses `#!/usr/bin/env -S uv run` shebang
- Inline dependency declaration
- Argparse CLI interface

**For `--with-tool go`:**

Create `scripts/<skill-name>.go` from `templates/go-tool.go.template`:
- Single-file Go program
- Installable via `go install`
- Flag-based CLI interface

### Phase 6: Finalize

Run validation and update manifests:

```bash
# Validate the new skill
./scripts/validate-skill.sh skill-packs/<category>/<skill-name>

# Update pack definition
# Edit skill-packs/<category>/PACK.md to add the new skill

# Regenerate catalog
./scripts/generate-catalog.sh

# Regenerate marketplace
./scripts/generate-marketplace.sh
```

### Phase 7: Commit Instructions

Provide the user with commit commands:

```bash
# Stage the new skill
git add skill-packs/<category>/<skill-name>

# Stage updated files
git add skill-packs/<category>/PACK.md
git add CATALOG.md
git add .claude-plugin/marketplace.json

# Commit
git commit -m "feat(skills): add <skill-name> skill"

# Push (if on feature branch)
git push origin <branch-name>
```

---

## References

- `references/skill-structure.md` - Complete structure documentation
- `references/naming-conventions.md` - Naming rules and examples
- `references/tool-templates.md` - UV and Go template details
- `templates/SKILL-TEMPLATE.md` - SKILL.md template
- `templates/uv-script.py.template` - UV Python script template
- `templates/go-tool.go.template` - Go binary template

---

## Example Usage

**Input:**
```
/skill-builder invoice-reminder --category client --with-tool uv
```

**Interview Flow:**
```
> Skill name: invoice-reminder ✓ (valid)
> Category: client ✓ (exists)

Please describe what this skill does:
> "Send reminder emails for overdue invoices. Takes a list of invoices and generates personalized reminder emails with escalating urgency."

What are the main workflow steps?
> 1. Load invoice data (CSV or JSON)
> 2. Filter for overdue invoices
> 3. Generate reminder email for each
> 4. Output emails ready to send

What arguments should the tool accept?
> --input <file> --days-overdue <N> --output <dir>
```

**Output:**
```
✅ Created skill-packs/client/invoice-reminder/
   ├── SKILL.md
   ├── scripts/invoice-reminder.py
   └── user/
       ├── .gitignore
       └── context.md.template

Next steps:
1. Review and customize SKILL.md
2. Implement scripts/invoice-reminder.py
3. Run: ./scripts/validate-skill.sh skill-packs/client/invoice-reminder
4. Update skill-packs/client/PACK.md
5. Run: ./scripts/generate-catalog.sh && ./scripts/generate-marketplace.sh
6. Commit your changes
```

---

## Guidelines

- Always validate before generating
- Keep skill names concise but descriptive
- Prefer UV Python for quick scripts, Go for distributable tools
- Include at least one example in every SKILL.md
- Run validation before committing

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Name validation fails | Use lowercase letters and hyphens only |
| Category doesn't exist | Create category directory first or choose existing |
| Tool template missing | Check `templates/` directory exists |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-02 | Initial release |
