---
name: {{pack-name}}
displayName: {{Pack Display Name}}
description: {{Pack description for marketing}}
version: 1.0.0
tier: free | pro | skool
price: {{0 | 47 | 97}}
skills:
  - {{skill-1}}
  - {{skill-2}}
  - {{skill-3}}
---

# {{Pack Display Name}}

## What's Included

This pack contains {{N}} skills designed to {{value proposition}}.

### Skills

| Skill | Description | Platforms |
|-------|-------------|-----------|
| {{skill-1}} | {{description}} | Claude, Claude Code, OpenClaw, Codex |
| {{skill-2}} | {{description}} | Claude, Claude Code, OpenClaw, Codex |

## Who This Is For

- {{Target user 1}}
- {{Target user 2}}

## Quick Start

```bash
# Install all free skills
npx returnmytime add skill ReturnMyTime/skills

# Install this pack (paid)
npx returnmytime add skill ./{{pack-name}}-v{{version}}.zip
```

## Installation

### Using returnmytime-cli (Recommended)

```bash
# Install all skills from the public repo
npx returnmytime add skill ReturnMyTime/skills

# Install a single skill
npx returnmytime add skill ReturnMyTime/skills/skill-packs/{{pack-name}}/{{skill-name}}

# Install a paid pack zip
npx returnmytime add skill ./{{pack-name}}-v{{version}}.zip
```

### Manual Installation (Claude Projects only)

1. Go to claude.ai -> Projects
2. Create a new project or open existing
3. Drag and drop each SKILL.md file into the project

## Support

- **Free users:** Community support via GitHub issues
- **Pro users:** Email support at hello@returnmytime.com
- **Skool members:** Priority support + community + live calls

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | {{YYYY-MM-DD}} | Initial release |
