# Contributing

Thanks for improving Return My Time skills.

## Add or Update a Skill

1. Create a folder under `skill-packs/<category>/<skill-name>/`.
2. Add a `SKILL.md` with YAML frontmatter.
3. Include supporting files (references, scripts, templates) in the same folder.
4. Run validation and update the catalog:

```bash
./scripts/validate-skill.sh skill-packs/<category>/<skill-name>
./scripts/generate-catalog.sh
./scripts/generate-marketplace.sh
```

## Frontmatter Requirements

Minimum required fields:

```yaml
name: skill-name
description: Clear description of what the skill does and when to use it.
version: 1.0.0
platforms:
  - claude
  - claude-code
  - openclaw
  - codex
tier: free | pro | skool
category: email | content | research | client | coding | sales | automation | brand | launch
requires: []
env: []
```

## Skill Packs

Define packs under `skill-packs/<category>/PACK.md`. The build script creates a zip by copying skills from `skill-packs/<category>/` (or `skills/` if present) based on the pack list.

## Release Assets (Manual)

Release assets are built and uploaded via a manual GitHub Actions workflow (no automatic triggers).

Local build:

```bash
./scripts/build-artifacts.sh
```

GitHub Actions:

1. Open the `Release Skill Assets` workflow.
2. Click **Run workflow** and provide a tag (e.g., `v2026-02-01`).
3. Download assets from the GitHub Release page.

## Commit Checklist

- `SKILL.md` frontmatter is valid
- Skill folder contains all required references
- `CATALOG.md` is regenerated
- `.claude-plugin/marketplace.json` is regenerated
- Pack definitions are up to date
