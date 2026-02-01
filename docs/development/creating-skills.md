# Creating Skills

## 1. Create the Folder

```bash
mkdir -p skills/<skill-name>
```

## 2. Add SKILL.md

Start from `templates/SKILL-TEMPLATE.md` and fill out the frontmatter and content.

## 3. Add Supporting Files

Place references, scripts, or templates inside the same skill folder.

## 4. Validate

```bash
./scripts/validate-skill.sh skills/<skill-name>
```

## 5. Update Catalog

```bash
./scripts/generate-catalog.sh
```
