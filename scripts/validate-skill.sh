#!/usr/bin/env bash
set -euo pipefail

SKILL_PATH="${1:-}"
if [[ -z "$SKILL_PATH" ]]; then
  echo "Usage: ./scripts/validate-skill.sh <skill-packs/<category>/<skill-name>>" >&2
  exit 1
fi

SKILL_FILE="$SKILL_PATH/SKILL.md"
if [[ ! -f "$SKILL_FILE" ]]; then
  echo "SKILL.md not found: $SKILL_FILE" >&2
  exit 1
fi

SKILL_FILE="$SKILL_FILE" python3 - <<'PY'
import os
import re
import sys
from pathlib import Path

skill_file = Path(os.environ["SKILL_FILE"])
text = skill_file.read_text(encoding="utf-8")

if not text.startswith("---\n"):
    raise SystemExit("Missing frontmatter start '---'")

match = re.search(r"^---\n(.*?)\n---\n", text, re.S)
if not match:
    raise SystemExit("Missing frontmatter end '---'")

front = match.group(1)

required = ["name", "description", "version", "platforms", "tier", "category"]
missing = [key for key in required if re.search(rf"^{key}:", front, re.M) is None]
if missing:
    raise SystemExit("Missing required fields: " + ", ".join(missing))

# Description length check
m = re.search(r"^description:\s*(.*)$", front, re.M)
desc = ""
if m:
    desc = m.group(1).strip()
if desc.startswith(">") or desc.startswith("|") or desc == "":
    # Multi-line or block; grab lines after description
    lines = front.splitlines()
    for i, line in enumerate(lines):
        if line.startswith("description:"):
            desc_lines = []
            for nxt in lines[i+1:]:
                if re.match(r"^[a-zA-Z_].*:\s*", nxt):
                    break
                desc_lines.append(nxt.strip())
            desc = " ".join([d for d in desc_lines if d])
            break

if len(desc) < 50:
    raise SystemExit("Description too short (<50 chars)")

if "{{" in text:
    raise SystemExit("Found template placeholder '{{' in SKILL.md")

# If user directory exists, ensure .gitignore
user_dir = skill_file.parent / "user"
if user_dir.exists() and not (user_dir / ".gitignore").exists():
    raise SystemExit("user/ exists without .gitignore")

# If env list is non-empty, require .env.example
has_env_items = False
in_env = False
for line in front.splitlines():
    if line.startswith("env:"):
        in_env = True
        continue
    if in_env:
        if re.match(r"^[a-zA-Z_].*:\s*", line):
            break
        if re.match(r"\s*-\s*\S+", line):
            has_env_items = True
            break

if has_env_items:
    env_example = skill_file.parent / ".env.example"
    if not env_example.exists():
        raise SystemExit("env list present but .env.example missing")

print(f"OK: {skill_file}")
PY
