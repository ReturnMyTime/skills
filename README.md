# Return My Time Skills

CLI-first skill library for Return My Time. Install skills with `returnmytime-cli` and use them across 40+ AI coding agents.

## Table of Contents

- [Quick Start](#quick-start)
- [Install Options](#install-options)
- [Skill Packs](#skill-packs)
- [Browse Skills](#browse-skills)
- [Repository Structure](#repository-structure)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Quick Start

```bash
# Install all public skills
npx returnmytime add skill ReturnMyTime/skills

# Or browse first
npx returnmytime find skill
```

## Install Options

```bash
# Install a single skill
npx returnmytime add skill ReturnMyTime/skills/skills/atomic-implementation-plan

# Install a pack zip
npx returnmytime add skill ./development-v1.0.0.zip

# Update installed skills
npx returnmytime update skill

# List installed skills
npx returnmytime list skill
```

## Skill Packs

This repo ships free skill packs under `skill-pack/`.

- `skill-pack/development` - development workflows and planning skills
- `skill-pack/productivity` - documentation and SOP workflows

To install a paid pack zip:

```bash
npx returnmytime add skill ./<pack-name>-v<version>.zip
```

## Browse Skills

See the full list in [CATALOG.md](./CATALOG.md).

## Repository Structure

```
skills/                 # Individual skill folders (source of truth)
skill-pack/             # Pack definitions (PACK.md + README.md)
templates/              # SKILL.md + PACK.md templates
scripts/                # Build + validation tooling
/docs                   # Installation, development, personalization guides
```

## Maintainers

Artifacts (pack + skill zips) are published via a manual GitHub Actions workflow:

- Run locally: `./scripts/build-artifacts.sh`
- Or trigger the `Build Skill Artifacts` workflow in GitHub Actions (manual trigger only)

Artifacts are not stored in git.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

Apache-2.0. See [LICENSE](./LICENSE).
