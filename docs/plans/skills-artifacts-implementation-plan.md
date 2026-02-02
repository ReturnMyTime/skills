# Implementation Plan: Manual GitHub Artifacts + Skill Zips

## Overview
Add a manual GitHub Actions workflow to build downloadable artifacts for both pack zips and individual skill zips, remove `dist/` zips from version control, and extend local scripts to generate a `mana-spec` artifact with checksums and metadata.

## Prerequisites
- [x] Confirm `mana-spec` filename + schema (assume `dist/mana-spec.json` listing artifacts + sha256)
- [x] Ensure GitHub Actions is enabled for the repository (manual trigger only)

## Phase 1: Repo Alignment & Cleanup

### Objective
Stop tracking release zips in git and align `.gitignore` with artifact-only distribution.

### Tasks
- [x] Remove tracked `dist/*.zip` and `dist/*.sha256` from git history (keep files locally if needed)
- [x] Update `.gitignore` to ignore all `dist/` outputs (no zip tracking)
- [x] Add or update maintainer docs to note artifacts are produced via manual workflow only

### Quality Gate
- [x] `git status` is clean with no `dist/` zip files tracked

## Phase 2: Build Tooling Enhancements

### Objective
Support building individual skill zips and a unified `mana-spec` manifest locally and in CI.

### Tasks
- [x] Add `scripts/build-skill.sh` to build a single skill zip from `skills/<name>`
- [x] Add `scripts/build-all-skills.sh` to build zips for all skills
- [x] Update `scripts/build-all-packs.sh` (or add `scripts/build-artifacts.sh`) to:
  - [x] Build all pack zips
  - [x] Build all skill zips
  - [x] Generate `dist/mana-spec.json` with file list + sha256 + type (pack/skill)
- [x] Normalize checksum generation to a cross-platform method (Python or `sha256sum` fallback)

### Quality Gate
- [x] Local run produces pack zips, skill zips, and `mana-spec` without errors

## Phase 3: GitHub Actions (Manual Only)

### Objective
Provide a workflow-dispatch artifact build pipeline that uploads zips and `mana-spec` as artifacts.

### Tasks
- [x] Add `.github/workflows/build-artifacts.yml` with `workflow_dispatch` only
- [x] Workflow steps:
  - [x] Checkout
  - [x] Run build script to generate pack + skill zips + `mana-spec`
  - [x] Upload artifact(s) with `actions/upload-artifact@v4`
- [x] Upload includes:
  - [x] `dist/*.zip`
  - [x] `dist/skills/*.zip`
  - [x] `dist/mana-spec.json`
- [x] Document that workflow is triggered manually after version bumps

### Quality Gate
- [x] Manual workflow run uploads artifacts successfully
- [x] Artifacts contain all pack and skill zips

## Phase 4: Documentation Updates

### Objective
Update maintainer docs to reflect manual artifact workflow and artifact-based downloads.

### Tasks
- [x] Update `CONTRIBUTING.md` with manual workflow steps and where to download artifacts
- [x] Update `docs/development/testing-skills.md` to reference artifact build flow
- [x] Add note to `README.md` (maintainer section or note) that release zips are published via Actions artifacts only

### Quality Gate
- [x] Docs match actual build and distribution workflow

## Deployment

### Environment Changes
- [x] None

### Database/Migration
- [x] None

### Configuration
- [x] GitHub Actions enabled (manual trigger only)

## Verification Checklist
- [x] No `dist/` zips are tracked in git
- [x] `scripts/build-all-skills.sh` builds zips for every skill
- [x] `scripts/build-all-packs.sh` (or `build-artifacts.sh`) builds both packs + skills
- [x] `dist/mana-spec.json` includes all artifacts with sha256
- [x] Manual workflow uploads artifacts successfully

## Rollback Plan
Revert the workflow and script changes, restore previous `.gitignore`, and re-run builds locally if needed.

## Notes
- Assumption: `mana-spec` will be JSON at `dist/mana-spec.json` (adjust if you want a different filename or schema).
- Artifact retention uses repository defaults; no explicit `retention-days` will be set.
