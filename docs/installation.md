# Installation Guide

This repository is CLI-first. Use `returnmytime-cli` to install skills for your agent.

## Quick Start

```bash
# Install all free skills
npx returnmytime add skill ReturnMyTime/skills

# Browse available skills
npx returnmytime find skill
```

## Install a Single Skill

```bash
npx returnmytime add skill ReturnMyTime/skills/skills/atomic-implementation-plan
```

## Install a Paid Pack Zip

```bash
npx returnmytime add skill ./<pack-name>-v<version>.zip
```

## Update or List Skills

```bash
npx returnmytime update skill
npx returnmytime list skill
```

## Manual Install (Fallback for Claude Projects)

1. Open claude.ai -> Projects
2. Create or open a project
3. Drag and drop the `SKILL.md` files into the project

## Troubleshooting

- If a skill does not show up, re-run `npx returnmytime list skill` and confirm the install path.
- If a pack zip fails to install, verify it contains skill folders at the zip root.
