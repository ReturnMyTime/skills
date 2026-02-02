# Implementation Plan: Free Skills Phase 1

## Overview

Add three new free skills to the public `ReturnMyTime/skills` repository:
1. `quick-reply` (productivity) - Draft professional email replies
2. `meeting-prep` (productivity) - Generate meeting briefings
3. `skill-builder` (productivity) - Meta skill for creating new skills with best practices

## Prerequisites

- [ ] Local clone of `~/Projects/skills` is up to date with `origin/main`
- [ ] Node.js installed (for `npx returnmytime` testing)
- [ ] Python 3 installed (for catalog/marketplace generation)

---

## Phase 1: Repository Setup & Branch Creation

### Objective
Create feature branch and verify environment.

### Tasks
- [ ] **1.1.1** Sync with remote: `git fetch origin && git pull origin main`
- [ ] **1.1.2** Create feature branch: `git checkout -b feature/free-skills-phase1`
- [ ] **1.1.3** Verify scripts are executable: `ls -la scripts/*.sh`

### Quality Gate
- [ ] On `feature/free-skills-phase1` branch
- [ ] Clean working tree (`git status` shows nothing to commit)

---

## Phase 2: Create `quick-reply` Skill

### Objective
Create a productivity skill for drafting professional email replies.

### Tasks
- [ ] **2.1.1** Create skill directory: `mkdir -p skill-packs/productivity/quick-reply`
- [ ] **2.1.2** Create `skill-packs/productivity/quick-reply/SKILL.md` with:
  - Frontmatter: name, description, version 1.0.0, tier: free, category: productivity
  - Workflow: Input email → Analyze tone/context → Generate 2-3 reply options
  - Tone variants: professional, friendly, direct
  - Output format: numbered options with send-ready text
- [ ] **2.1.3** Add user personalization support:
  - Create `skill-packs/productivity/quick-reply/user/` directory
  - Create `context.md.template` with business context fields
  - Create `.gitignore` to exclude `context.md`
- [ ] **2.1.4** Validate skill: `./scripts/validate-skill.sh skill-packs/productivity/quick-reply`
- [ ] **2.1.5** Commit: `git add skill-packs/productivity/quick-reply && git commit -m "feat(skills): add quick-reply skill"`

### Quality Gate
- [ ] Validation passes
- [ ] SKILL.md follows template structure
- [ ] User personalization directory exists

---

## Phase 3: Create `meeting-prep` Skill

### Objective
Create a productivity skill for generating meeting briefings.

### Tasks
- [ ] **3.1.1** Create skill directory: `mkdir -p skill-packs/productivity/meeting-prep`
- [ ] **3.1.2** Create `skill-packs/productivity/meeting-prep/SKILL.md` with:
  - Frontmatter: name, description, version 1.0.0, tier: free, category: productivity
  - Workflow phases:
    1. Gather meeting context (attendees, topic, goals)
    2. Research attendees (LinkedIn, company, recent news)
    3. Generate briefing document
  - Output sections: Attendee profiles, Agenda suggestions, Talking points, Questions to ask, Follow-up template
- [ ] **3.1.3** Create `skill-packs/productivity/meeting-prep/references/` directory
- [ ] **3.1.4** Create `references/briefing-template.md` with output format
- [ ] **3.1.5** Add user personalization support:
  - Create `user/` directory with `context.md.template`
  - Include fields: Your role, Company context, Meeting preferences
- [ ] **3.1.6** Validate skill: `./scripts/validate-skill.sh skill-packs/productivity/meeting-prep`
- [ ] **3.1.7** Commit: `git add skill-packs/productivity/meeting-prep && git commit -m "feat(skills): add meeting-prep skill"`

### Quality Gate
- [ ] Validation passes
- [ ] References directory contains template
- [ ] User personalization directory exists

---

## Phase 4: Create `skill-builder` Skill

### Objective
Create a meta skill that generates new skills following repository best practices, with support for single-file tools (UV Python scripts or Go binaries).

### Tasks

#### 4.1 Core SKILL.md
- [ ] **4.1.1** Create skill directory: `mkdir -p skill-packs/productivity/skill-builder`
- [ ] **4.1.2** Create `skill-packs/productivity/skill-builder/SKILL.md` with:
  - Frontmatter: name, description, version 1.0.0, tier: free, category: productivity
  - Workflow phases:
    1. **Interview** - Gather skill requirements (name, description, category, workflow)
    2. **Validate** - Check naming conventions, category existence
    3. **Generate** - Create skill directory structure
    4. **Tool Support** - Optionally generate single-file tools
    5. **Finalize** - Run validation, update catalog/marketplace
  - argument-hint: `[skill-name] [--category <category>] [--with-tool <uv|go>]`

#### 4.2 Reference Documentation
- [ ] **4.2.1** Create `references/` directory
- [ ] **4.2.2** Create `references/skill-structure.md`:
  - Required files: `SKILL.md`
  - Optional directories: `scripts/`, `references/`, `user/`, `templates/`
  - Frontmatter schema with all fields
  - Category enum: `email | content | research | client | coding | sales | automation | brand | launch | productivity`
- [ ] **4.2.3** Create `references/naming-conventions.md`:
  - Skill names: lowercase, hyphenated (e.g., `quick-reply`)
  - No underscores, no camelCase
  - Descriptive but concise (2-4 words max)
- [ ] **4.2.4** Create `references/tool-templates.md`:
  - UV Python script template (single-file, `#!/usr/bin/env -S uv run`)
  - Go binary template (single-file, installable via `go install`)
  - When to use each: Python for quick scripts, Go for distributable CLIs

#### 4.3 Script Templates
- [ ] **4.3.1** Create `templates/` directory
- [ ] **4.3.2** Create `templates/SKILL-TEMPLATE.md` (copy from repo root)
- [ ] **4.3.3** Create `templates/uv-script.py.template`:
  ```python
  #!/usr/bin/env -S uv run
  # /// script
  # requires-python = ">=3.11"
  # dependencies = []
  # ///
  """{{description}}"""
  
  import argparse
  
  def main():
      parser = argparse.ArgumentParser(description="{{description}}")
      # Add arguments here
      args = parser.parse_args()
      # Implementation here
  
  if __name__ == "__main__":
      main()
  ```
- [ ] **4.3.4** Create `templates/go-tool.go.template`:
  ```go
  //go:build ignore
  
  // {{description}}
  // Install: go install github.com/ReturnMyTime/skills/skill-packs/{{category}}/{{skill-name}}/scripts/{{tool-name}}.go@latest
  
  package main
  
  import (
      "flag"
      "fmt"
  )
  
  func main() {
      // Add flags here
      flag.Parse()
      // Implementation here
  }
  ```

#### 4.4 Workflow Implementation
- [ ] **4.4.1** Define generation workflow in SKILL.md:
  1. Validate skill name (lowercase, hyphenated)
  2. Validate or create category directory
  3. Create skill directory structure
  4. Generate SKILL.md from interview answers
  5. If `--with-tool uv`: Generate UV Python script template
  6. If `--with-tool go`: Generate Go binary template
  7. Create user/ directory with .gitignore
  8. Run `./scripts/validate-skill.sh`
  9. Update PACK.md to include new skill
  10. Run `./scripts/generate-catalog.sh`
  11. Run `./scripts/generate-marketplace.sh`
  12. Provide commit instructions

#### 4.5 Validation & Commit
- [ ] **4.5.1** Validate skill: `./scripts/validate-skill.sh skill-packs/productivity/skill-builder`
- [ ] **4.5.2** Commit: `git add skill-packs/productivity/skill-builder && git commit -m "feat(skills): add skill-builder meta skill"`

### Quality Gate
- [ ] Validation passes
- [ ] References cover all best practices
- [ ] Templates are complete and valid
- [ ] Workflow is comprehensive

---

## Phase 5: Update Pack Definitions

### Objective
Add new skills to their respective pack definitions.

### Tasks
- [ ] **5.1.1** Update `skill-packs/productivity/PACK.md`:
  - Add `quick-reply` to skills list
  - Add `meeting-prep` to skills list
  - Add `skill-builder` to skills list
- [ ] **5.1.2** Commit: `git add skill-packs/productivity/PACK.md && git commit -m "chore(packs): add new skills to pack definitions"`

### Quality Gate
- [ ] Both PACK.md files updated
- [ ] Skills listed alphabetically

---

## Phase 6: Regenerate Catalog & Marketplace

### Objective
Update auto-generated files to include new skills.

### Tasks
- [ ] **6.1.1** Regenerate catalog: `./scripts/generate-catalog.sh`
- [ ] **6.1.2** Regenerate marketplace: `./scripts/generate-marketplace.sh`
- [ ] **6.1.3** Validate marketplace: `./scripts/validate-marketplace.sh`
- [ ] **6.1.4** Commit: `git add CATALOG.md .claude-plugin/marketplace.json && git commit -m "chore: regenerate catalog and marketplace"`

### Quality Gate
- [ ] CATALOG.md includes all 3 new skills
- [ ] marketplace.json is valid JSON
- [ ] Marketplace validation passes

---

## Phase 7: Testing

### Objective
Verify skills work correctly with the CLI.

### Tasks
- [ ] **7.1.1** Install skills locally: `npx returnmytime add skill . --agent claude-code`
- [ ] **7.1.2** Verify `quick-reply` loads in Claude Code
- [ ] **7.1.3** Verify `meeting-prep` loads in Claude Code
- [ ] **7.1.4** Verify `skill-builder` loads in Claude Code
- [ ] **7.1.5** Test `skill-builder` by generating a test skill (then delete it)
- [ ] **7.1.6** Document any issues found

### Quality Gate
- [ ] All skills install successfully
- [ ] All skills are recognized by Claude Code
- [ ] skill-builder can generate a valid skill structure

---

## Phase 8: Push & Pull Request

### Objective
Submit changes for review and merge.

### Tasks
- [ ] **8.1.1** Push branch: `git push -u origin feature/free-skills-phase1`
- [ ] **8.1.2** Create Pull Request with:
  - Title: `feat: add quick-reply, meeting-prep, and skill-builder skills`
  - Description: Summary of changes, link to this plan
  - Labels: `enhancement`, `skills`
- [ ] **8.1.3** Request review (if applicable)
- [ ] **8.1.4** Address any review feedback
- [ ] **8.1.5** Merge PR to main
- [ ] **8.1.6** Delete feature branch: `git branch -d feature/free-skills-phase1`

### Quality Gate
- [ ] PR is approved
- [ ] CI passes (if configured)
- [ ] Merged to main

---

## Appendix A: Skill Summary

| Skill | Category | Pack | Description |
|-------|----------|------|-------------|
| `quick-reply` | productivity | productivity | Draft professional email replies with tone variants |
| `meeting-prep` | productivity | productivity | Generate meeting briefings with attendee research |
| `skill-builder` | productivity | productivity | Meta skill for creating new skills with best practices |

---

## Appendix B: File Changes Summary

```
skill-packs/
└── productivity/
    ├── PACK.md                          # Updated
    ├── quick-reply/                     # NEW
    │   ├── SKILL.md
    │   └── user/
    │       ├── .gitignore
    │       └── context.md.template
    ├── meeting-prep/                    # NEW
    │   ├── SKILL.md
    │   ├── references/
    │   │   └── briefing-template.md
    │   └── user/
    │       ├── .gitignore
    │       └── context.md.template
    └── skill-builder/                   # NEW
        ├── SKILL.md
        ├── references/
        │   ├── skill-structure.md
        │   ├── naming-conventions.md
        │   └── tool-templates.md
        └── templates/
            ├── SKILL-TEMPLATE.md
            ├── uv-script.py.template
            └── go-tool.go.template

CATALOG.md                               # Regenerated
.claude-plugin/marketplace.json          # Regenerated
```

---

## Appendix C: Estimated Timeline

| Phase | Tasks | Estimated Duration |
|-------|-------|-------------------|
| 1. Repository Setup | 3 tasks | 5 minutes |
| 2. quick-reply Skill | 5 tasks | 30 minutes |
| 3. meeting-prep Skill | 7 tasks | 45 minutes |
| 4. skill-builder Skill | 12 tasks | 90 minutes |
| 5. Update Packs | 3 tasks | 10 minutes |
| 6. Regenerate Files | 4 tasks | 5 minutes |
| 7. Testing | 6 tasks | 20 minutes |
| 8. Push & PR | 6 tasks | 15 minutes |
| **Total** | **46 tasks** | **~4 hours** |

---

## Appendix D: Success Criteria

- [ ] All 3 skills pass validation
- [ ] CATALOG.md lists all new skills correctly
- [ ] Marketplace JSON is valid
- [ ] CLI can install all skills
- [ ] skill-builder can generate valid new skills
- [ ] PR merged to main

---

*Document Version: 1.0.0*
*Created: 2026-02-02*
*Author: Annie*
