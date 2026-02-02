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
npx returnmytime add skill ReturnMyTime/skills/skill-packs/development/atomic-implementation-plan

# Install a pack zip
npx returnmytime add skill ./development-v1.0.0.zip

# Update installed skills
npx returnmytime update skill

# List installed skills
npx returnmytime list skill
```

## Skill Packs

This repo ships free skill packs under `skill-packs/`.

- `skill-packs/development` - development workflows and planning skills
- `skill-packs/productivity` - documentation and SOP workflows

To install a paid pack zip:

```bash
npx returnmytime add skill ./<pack-name>-v<version>.zip
```

Pack and individual skill zips are published as GitHub Release assets.

## Browse Skills

See the full list in [CATALOG.md](./CATALOG.md).

## Repository Structure

```
skill-packs/            # Canonical skill folders by category
skills/                 # Optional legacy root (if needed)
templates/              # SKILL.md + PACK.md templates
scripts/                # Build + validation tooling
/docs                   # Installation, development, personalization guides
```

## Maintainers

Release assets (pack + skill zips) are published via a manual GitHub Actions workflow:

- Run locally: `./scripts/build-artifacts.sh`
- Or trigger the `Release Skill Assets` workflow in GitHub Actions (manual trigger only)

Assets are not stored in git; they live on GitHub Releases.

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

## License

Apache-2.0. See [LICENSE](./LICENSE).
