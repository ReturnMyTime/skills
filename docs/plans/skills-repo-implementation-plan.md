# Implementation Plan: Return My Time Skills Public Repo (v2.0)

## Overview
Build the public Return My Time skills repository at `~/Projects/skills`, using the v2.0 architecture with `returnmytime-cli` as the primary distribution path, and add the initial development and productivity skill packs.

## Prerequisites
- [x] Access to `~/Projects/skills` repository
- [x] Access to local skill sources (`~/.codex/skills`, `~/.claude/skills`, `~/.agents/skills`)
- [x] Review Anthropic Skills docs for required `SKILL.md` frontmatter and discovery paths

## Phase 1: Research & Inventory

### Objective
Confirm reference architecture patterns and inventory the skill sources to ingest.

### Tasks
- [x] Review Anthropic Claude Code skills requirements (SKILL.md frontmatter, discovery paths, zip layout)
- [x] Review `~/Projects/returnmytime-skills-private` for skill structure patterns (SKILL.md + supporting files)
- [x] Inventory the target skills to include:
  - `agentmd`
  - `atomic-implementation-plan`
  - `interview`
  - `llm-council`
  - `prime`
  - `remotion-best-practices`
  - `transcript-to-sop`
- [x] Decide pack layout: use `skill-pack/<category>` with no symlinks; build zips by copying from `/skills`

### Quality Gate
- [x] Reference architecture summarized and skill list confirmed

## Phase 2: Repository Bootstrap

### Objective
Create the public repo structure and baseline docs/config.

### Tasks
- [x] Create base directories: `skill-pack/`, `skills/`, `templates/`, `scripts/`, `docs/`
- [x] Add `.gitignore` for personalization files, OS/IDE artifacts, and build outputs
- [x] Replace `LICENSE` with Apache-2.0 (per v2.0 plan)
- [x] Create `README.md` with CLI-first installation and pack overview
- [x] Create `CATALOG.md` placeholder (generated later)
- [x] Create `CONTRIBUTING.md`

### Quality Gate
- [x] Repo structure and baseline docs exist

## Phase 3: Templates & Schema

### Objective
Provide consistent templates and frontmatter schema for future skills/packs.

### Tasks
- [x] Add `templates/SKILL-TEMPLATE.md` (v2.0 schema)
- [x] Add `templates/PACK-TEMPLATE.md` (CLI-first install)
- [x] Add `templates/.env.example`
- [x] Add `templates/user/context.md.template`
- [x] Add `templates/user/config.json.template`
- [x] Add `templates/user/.gitignore`

### Quality Gate
- [x] All templates are present and referenced in docs

## Phase 4: Skill Ingestion & Normalization

### Objective
Copy the specified skills into the public repo and normalize frontmatter to the v2.0 schema.

### Tasks
- [x] Copy skill folders into `skills/` from local sources:
  - [x] `agentmd` (from `~/.codex/skills/agentmd`)
  - [x] `atomic-implementation-plan` (from `~/.codex/skills/atomic-implementation-plan`)
  - [x] `interview` (from `~/.codex/skills/interview`)
  - [x] `llm-council` (from `~/.codex/skills/llm-council`)
  - [x] `prime` (from `~/.codex/skills/prime`)
  - [x] `remotion-best-practices` (from `~/.agents/skills/remotion-best-practices`)
  - [x] `transcript-to-sop` (from `~/.claude/skills/transcript-to-sop`)
- [x] Normalize each `SKILL.md` frontmatter to include:
  - `name`, `description`, `version`, `platforms`, `tier`, `category`, `requires`, `env`
  - Preserve any existing fields (e.g., `argument-hint`, `metadata`)
- [x] Assign categories:
  - Development pack skills -> `category: coding`
  - Transcript-to-SOP -> `category: automation`
- [x] Ensure descriptions are clear and >50 characters

### Quality Gate
- [x] All skills load with valid v2.0 frontmatter and no missing required fields

## Phase 5: Skill Pack Definitions

### Objective
Define the initial public skill packs using the new `skill-pack/` layout.

### Tasks
- [x] Create `skill-pack/development/` with `PACK.md` and `README.md`
- [x] Create `skill-pack/productivity/` with `PACK.md` and `README.md`
- [x] Define pack metadata and skill lists in each `PACK.md`
- [x] Ensure pack install instructions reference `returnmytime-cli`

### Quality Gate
- [x] Pack metadata is complete and aligned to skill list

## Phase 6: Tooling (CLI-Centric)

### Objective
Provide scripts for validating skills, generating catalogs, and building pack zips.

### Tasks
- [x] Add `scripts/build-pack.sh` to create a zip from a pack’s skill list
- [x] Add `scripts/build-all-packs.sh` to build all pack zips and manifest
- [x] Add `scripts/validate-skill.sh` for frontmatter/structure checks
- [x] Add `scripts/generate-catalog.sh` to build `CATALOG.md` from skill metadata
- [x] Make scripts executable

### Quality Gate
- [x] Scripts run without errors on the initial repo state

## Phase 7: Documentation

### Objective
Ship CLI-first documentation for users and maintainers.

### Tasks
- [x] Add `docs/installation.md` (CLI install + usage)
- [x] Add `docs/development/creating-skills.md`
- [x] Add `docs/development/skill-structure.md`
- [x] Add `docs/development/frontmatter-reference.md`
- [x] Add `docs/development/best-practices.md`
- [x] Add `docs/development/testing-skills.md`
- [x] Add `docs/personalization/getting-started.md`
- [x] Add `docs/personalization/context-file.md`
- [x] Add `docs/personalization/environment-variables.md`
- [x] Add `docs/personalization/examples.md`

### Quality Gate
- [x] Docs cover install, creation, and personalization flows

## Phase 8: Catalog & Verification

### Objective
Generate the catalog and verify packs/skills build correctly.

### Tasks
- [x] Run `scripts/generate-catalog.sh` to populate `CATALOG.md`
- [x] Run `scripts/validate-skill.sh` on all skills
- [x] Build pack zips for development and productivity packs
- [x] Verify zip contents include full skill directories

### Quality Gate
- [x] Catalog is generated and pack zips build successfully

## Deployment

### Environment Changes
- [x] None

### Database/Migration
- [x] None

### Configuration
- [x] None

## Verification Checklist
- [x] `skills/` contains all requested skills
- [x] Each `SKILL.md` includes v2.0 frontmatter fields
- [x] `skill-pack/development` and `skill-pack/productivity` contain valid `PACK.md`
- [x] `scripts/build-pack.sh` produces a usable zip
- [x] `CATALOG.md` lists all skills and pack membership

## Rollback Plan
Revert the repository to the previous commit, or remove newly added files/directories if uncommitted.

## Notes
- Pack zips are built by copying skills from `/skills` based on `PACK.md` lists (no symlinks).
- Skills are CLI-first; manual installation is provided only as a fallback.
