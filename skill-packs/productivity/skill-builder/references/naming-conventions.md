# Naming Conventions

Rules and examples for naming skills, files, and directories.

---

## Skill Names

### Rules

1. **Lowercase only** - No uppercase letters
2. **Hyphen-separated** - Use `-` to separate words
3. **No underscores** - Use hyphens instead
4. **No camelCase** - Use hyphens instead
5. **2-4 words** - Concise but descriptive
6. **Action-oriented** - Describe what it does

### Valid Examples

| Name | Description |
|------|-------------|
| `quick-reply` | ✅ Clear action, 2 words |
| `meeting-prep` | ✅ Clear action, 2 words |
| `skill-builder` | ✅ Clear purpose, 2 words |
| `transcript-to-sop` | ✅ Describes transformation, 3 words |
| `atomic-implementation-plan` | ✅ Specific purpose, 3 words |

### Invalid Examples

| Name | Issue | Fix |
|------|-------|-----|
| `QuickReply` | ❌ CamelCase | `quick-reply` |
| `quick_reply` | ❌ Underscores | `quick-reply` |
| `QUICK-REPLY` | ❌ Uppercase | `quick-reply` |
| `qr` | ❌ Too short/unclear | `quick-reply` |
| `really-long-skill-name-here` | ❌ Too long (5 words) | Shorten |
| `skill` | ❌ Too generic | Be specific |

---

## Directory Names

### Category Directories

Use singular, lowercase names:

```
skill-packs/
├── productivity/    ✅
├── coding/          ✅
├── email/           ✅
├── content/         ✅
├── Productivity/    ❌ (uppercase)
├── emails/          ❌ (plural)
```

### Skill Directories

Match the skill name exactly:

```
skill-packs/productivity/
├── quick-reply/           # Matches name: quick-reply
├── meeting-prep/          # Matches name: meeting-prep
└── skill-builder/         # Matches name: skill-builder
```

---

## File Names

### Markdown Files

- Use lowercase with hyphens: `briefing-template.md`
- Use descriptive names: `naming-conventions.md` not `nc.md`
- SKILL.md is always uppercase (convention)
- PACK.md is always uppercase (convention)
- README.md is always uppercase (convention)

### Script Files

- Match the skill name when possible: `skill-builder.py`
- Use descriptive names for helpers: `validate-input.py`
- Extension indicates language: `.py`, `.go`, `.sh`

### Template Files

- Use `.template` suffix for user-facing templates
- Examples: `context.md.template`, `config.json.template`

---

## Frontmatter Values

### name Field

Must exactly match the directory name:

```yaml
# In skill-packs/productivity/quick-reply/SKILL.md
name: quick-reply  # ✅ Matches directory
name: Quick Reply  # ❌ Doesn't match
name: quickreply   # ❌ Doesn't match
```

### category Field

Must exactly match the category directory:

```yaml
# In skill-packs/productivity/
category: productivity  # ✅ Matches directory
category: Productivity  # ❌ Wrong case
category: prod          # ❌ Abbreviated
```

---

## Validation Regex

Use these patterns to validate names:

```python
# Skill name: 2-4 hyphen-separated lowercase words
SKILL_NAME_PATTERN = r'^[a-z]+(-[a-z]+){1,3}$'

# Category: single lowercase word
CATEGORY_PATTERN = r'^[a-z]+$'

# Version: semantic versioning
VERSION_PATTERN = r'^\d+\.\d+\.\d+$'
```

---

## Quick Reference

| Element | Format | Example |
|---------|--------|---------|
| Skill name | `word-word` | `quick-reply` |
| Category | `word` | `productivity` |
| Directory | `lowercase-hyphen/` | `skill-builder/` |
| Markdown | `lowercase-hyphen.md` | `naming-conventions.md` |
| Script | `skill-name.ext` | `skill-builder.py` |
| Template | `name.ext.template` | `context.md.template` |
