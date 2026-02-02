# Implementation Plan: Anthropic-Style Skill-Packs + Releases

## Overview
Restructure the repository to mirror Anthropic's skills layout conventions (self-contained skill folders with `SKILL.md` under a skills root) by adopting `skill-packs/<category>/<skill>/` as the canonical skill location, update tooling to scan both `skill-packs/` and `skills/`, and switch distribution to manual GitHub Releases containing pack and individual skill zips.

## Prerequisites
- [x] Confirm new canonical paths: `skill-packs/<category>/<skill>/SKILL.md`
- [x] Confirm that GitHub Releases (manual trigger) are the sole distribution channel for zip artifacts

## Phase 1: Research & Inventory

### Objective
Document Anthropic's directory conventions and inventory current repo layout to map the migration.

### Tasks
- [x] Record Anthropic's repo root listing that includes a `skills/` directory and states each skill is self-contained in its own folder with a `SKILL.md` file.
- [x] Review current repo layout (`skill-packs/`, `skills/`, `scripts/`, `docs/`) and existing build tooling paths to identify all references to `skill-packs/` and `skills/`.

### Quality Gate
- [x] Source notes reflect Anthropic's directory conventions and a complete list of current repo paths needing changes

## Phase 2: Directory Restructure (Canonical Skill-Packs)

### Objective
Move to `skill-packs/<category>/<skill>/` as the canonical location for skill folders while keeping pack metadata at the category root.

### Tasks
- [x] Rename `skill-pack/` -> `skill-packs/` (plural) across the repo (directories, docs, scripts).
- [x] Create category roots: `skill-packs/development/` and `skill-packs/productivity/`.
- [x] Move each skill into its category folder:
  - [x] `agentmd` -> `skill-packs/development/agentmd/`
  - [x] `atomic-implementation-plan` -> `skill-packs/development/atomic-implementation-plan/`
  - [x] `interview` -> `skill-packs/development/interview/`
  - [x] `llm-council` -> `skill-packs/development/llm-council/`
  - [x] `prime` -> `skill-packs/development/prime/`
  - [x] `remotion-best-practices` -> `skill-packs/development/remotion-best-practices/`
  - [x] `transcript-to-sop` -> `skill-packs/productivity/transcript-to-sop/`
- [x] Keep pack metadata and README files at `skill-packs/<category>/PACK.md` and `skill-packs/<category>/README.md` (update content if needed).
- [x] Decide how to handle `skills/` root (legacy path):
  - [x] Option A: remove `skills/` and update docs/examples to new paths only
  - [ ] Option B: keep `skills/` as a generated mirror (copy/sync from `skill-packs/`)

### Quality Gate
- [x] Canonical skill folders live under `skill-packs/<category>/<skill>/` and pack metadata remains at category root

## Phase 3: Tooling Updates (Scan Both Roots)

### Objective
Update build, validation, and catalog tooling to support both `skill-packs/` and `skills/` roots.

### Tasks
- [x] Update `scripts/build-pack.sh` to read `skill-packs/<category>/PACK.md` and copy skill folders from the new canonical path.
- [x] Update `scripts/build-skill.sh` to accept a skill name and resolve it across both roots (prefer `skill-packs/` if present).
- [x] Update `scripts/build-all-skills.sh` to traverse `skill-packs/*/*/SKILL.md` and `skills/*/SKILL.md`.
- [x] Update `scripts/generate-catalog.sh` to scan both roots and include pack membership from `skill-packs/<category>/PACK.md`.
- [x] Update validation script(s) to support the new canonical path and ensure metadata remains intact.

### Quality Gate
- [x] Local scripts build pack zips and skill zips from the new structure without errors

## Phase 4: Release-Based Distribution (Manual)

### Objective
Replace GitHub Actions artifacts with manual GitHub Releases that store pack and skill zip assets.

### Tasks
- [x] Add/update a release workflow (`workflow_dispatch` only) to:
  - [x] Build all pack zips + individual skill zips
  - [x] Generate `dist/mana-spec.json`
  - [x] Create or update a GitHub Release with assets (pack zips, skill zips, `mana-spec`)
- [x] Decide release tag/version strategy (e.g., `v<date>` or `v<repo-version>`), and ensure pack/skill versions are taken from `PACK.md` / `SKILL.md`.
- [x] Update `.gitignore` to ensure `dist/` stays untracked.
- [x] Remove legacy artifact upload workflow (if it conflicts with release flow).

### Quality Gate
- [x] Manual release workflow completes and uploads all zip assets + `mana-spec`

## Phase 5: Documentation & Examples

### Objective
Update docs to reflect the new paths and release-based distribution.

### Tasks
- [x] Update `README.md` to use `skill-packs/<category>/<skill>` paths in examples.
- [x] Update `docs/installation.md` with the new skill URLs and release download instructions.
- [x] Update `CONTRIBUTING.md` to describe `skill-packs/` as canonical and document the release workflow.
- [x] Update any plan or docs referencing `skill-packs/` or `skills/` paths.

### Quality Gate
- [x] Documentation matches the new directory structure and release flow

## Deployment

### Environment Changes
- [x] None

### Database/Migration
- [x] None

### Configuration
- [x] GitHub Actions manual release workflow enabled

## Verification Checklist
- [x] Skills exist under `skill-packs/<category>/<skill>/` with intact `SKILL.md`
- [x] Pack metadata exists at `skill-packs/<category>/PACK.md`
- [x] Tooling scans both `skill-packs/` and `skills/`
- [x] Manual GitHub Release includes all pack zips + individual skill zips + `mana-spec`
- [x] Docs reference new paths and release flow

## Rollback Plan
Revert directory renames and restore the prior `skill-packs/` + `skills/` layout, then re-run build scripts to restore previous packaging.

## Notes
- Anthropic's repo documents a `skills/` root and notes that each skill is a folder with a `SKILL.md`.
