# Contributing

Thanks for improving Return My Time skills.

## Add or Update a Skill

1. Create a folder under `skills/<skill-name>/`.
2. Add a `SKILL.md` with YAML frontmatter.
3. Include supporting files (references, scripts, templates) in the same folder.
4. Run validation and update the catalog:

```bash
./scripts/validate-skill.sh skills/<skill-name>
./scripts/generate-catalog.sh
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

Define packs under `skill-pack/<category>/PACK.md`. The build script creates a zip by copying skills from `skills/` based on the pack list.

## Release Artifacts (Manual)

Artifacts are built and uploaded via a manual GitHub Actions workflow (no automatic triggers).

Local build:

```bash
./scripts/build-artifacts.sh
```

GitHub Actions:

1. Open the `Build Skill Artifacts` workflow.
2. Click **Run workflow**.
3. Download artifacts from the run summary.

## Commit Checklist

- `SKILL.md` frontmatter is valid
- Skill folder contains all required references
- `CATALOG.md` is regenerated
- Pack definitions are up to date
