# Implementation Plan: Claude Plugin Marketplace for Return My Time Skills

## Overview
Add a Claude Code plugin marketplace to the public skills repository by auto-generating `.claude-plugin/marketplace.json` from the canonical `skill-packs/*/*/SKILL.md` files, with one plugin per skill and fully automated versioning.

## Prerequisites
- [ ] Access to `/Users/nick/Projects/skills` on branch `chore/claude-marketplace`
- [ ] Confirm Claude Code marketplace command set is available for local testing (`/plugin marketplace ...`)
- [ ] Python 3 available for generator scripts

## Phase 1: Research and Mapping

### Objective
Confirm the marketplace schema and define the mapping from SKILL.md to plugin entries.

### Tasks
- [ ] Review `/Users/nick/Projects/returnmytime-skills-private/.claude-plugin/marketplace.json` and note required fields
- [ ] Inventory all skills at `skill-packs/*/*/SKILL.md` and confirm unique `name` values
- [ ] Define canonical mapping:
  - `plugins[].name` = SKILL.md `name`
  - `plugins[].description` = SKILL.md `description`
  - `plugins[].category` = SKILL.md `category`
  - `plugins[].skills` = relative path to the skill folder
  - `plugins[].tags` = minimal tag list (single tag)
- [ ] Decide version strategy: computed automatically from git state and applied to both `metadata.version` and each plugin `version`

### Quality Gate
- [ ] Mapping table and version strategy approved

## Phase 2: Marketplace Generator Automation

### Objective
Create an automated generator that produces a stable, valid marketplace.json with no manual edits.

### Tasks
- [ ] Create `.claude-plugin/` directory at repo root
- [ ] Add `scripts/generate-marketplace.sh` (or `scripts/generate-marketplace.py`) to:
  - [ ] Scan `skill-packs/*/*/SKILL.md` (and optionally `skills/*/SKILL.md` for legacy support)
  - [ ] Parse frontmatter for `name`, `description`, `category`, `version`
  - [ ] Build `plugins[]` with one entry per skill
  - [ ] Use `source: "./"`, `strict: false`, and `skills: ["./<skill-path>"]`
  - [ ] Apply a minimal tag list (single tag) to each plugin
  - [ ] Generate deterministic output ordering (sort by plugin name)
  - [ ] Compute version automatically from git (e.g., commit count or short SHA) and apply to:
    - [ ] `metadata.version`
    - [ ] every `plugins[].version`
  - [ ] Write `.claude-plugin/marketplace.json`
- [ ] Add `scripts/validate-marketplace.sh` to JSON-parse and validate required fields

### Quality Gate
- [ ] `scripts/generate-marketplace.*` produces a valid `.claude-plugin/marketplace.json`
- [ ] `scripts/validate-marketplace.sh` passes

## Phase 3: Workflow Integration

### Objective
Ensure marketplace.json is updated as part of existing maintenance workflows.

### Tasks
- [ ] Update `scripts/build-artifacts.sh` to run `scripts/generate-marketplace.*` before packaging
- [ ] Update `.github/workflows/release-assets.yml` to run the generator before building artifacts
- [ ] Add a short maintainer note in README/CONTRIBUTING on when to run the generator locally

### Quality Gate
- [ ] Release workflow builds artifacts with an up-to-date marketplace.json

## Phase 4: Documentation Updates

### Objective
Document Claude Code marketplace installation and update flow.

### Tasks
- [ ] Update `README.md` with Claude Code marketplace instructions:
  - [ ] `/plugin marketplace add ReturnMyTime/skills`
  - [ ] `/plugin install <skill>@ReturnMyTime/skills`
  - [ ] `/plugin marketplace update ReturnMyTime/skills`
- [ ] Update `docs/installation.md` with the same marketplace flow
- [ ] Note that marketplace entries are auto-generated and versioned (no manual edits)

### Quality Gate
- [ ] README and installation guide show the new marketplace workflow

## Phase 5: Verification

### Objective
Validate that the marketplace installs correctly and lists all skills.

### Tasks
- [ ] Run `scripts/generate-marketplace.*` and confirm output is valid JSON
- [ ] Verify each skill from `skill-packs/*/*` appears as a plugin entry
- [ ] Local test: `/plugin marketplace add /absolute/path/to/skills`
- [ ] Local test: `/plugin install <skill>@ReturnMyTime/skills`
- [ ] Local test: `/plugin marketplace update ReturnMyTime/skills` (post-change)

### Quality Gate
- [ ] Marketplace can be added locally and skills install successfully

## Deployment

### Environment Changes
- [ ] None

### Database/Migration
- [ ] None

### Configuration
- [ ] None

## Verification Checklist
- [ ] `.claude-plugin/marketplace.json` exists and is generated (not hand-edited)
- [ ] One plugin entry per skill
- [ ] Category and minimal tag applied
- [ ] Version is auto-derived and updates on repo change
- [ ] README/docs include Claude Code marketplace instructions

## Rollback Plan
Revert the commit(s) that add `.claude-plugin/` and generator scripts, then remove documentation references.

## Notes
- Versioning is intentionally automatic; no manual version edits are required.
- Minimal tag will be a single tag (e.g., `returnmytime`) applied uniformly unless otherwise specified.
