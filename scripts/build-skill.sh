#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="${1:-}"
if [[ -z "$SKILL_NAME" ]]; then
  echo "Usage: ./scripts/build-skill.sh <skill-name>" >&2
  exit 1
fi

SKILL_DIR="skills/$SKILL_NAME"
SKILL_FILE="$SKILL_DIR/SKILL.md"
if [[ ! -f "$SKILL_FILE" ]]; then
  echo "SKILL.md not found: $SKILL_FILE" >&2
  exit 1
fi

VERSION=$(SKILL_NAME="$SKILL_NAME" python3 - <<'PY'
import os
import re
from pathlib import Path

skill = Path("skills") / os.environ["SKILL_NAME"] / "SKILL.md"
text = skill.read_text(encoding="utf-8")
match = re.search(r"^---\n(.*?)\n---\n", text, re.S)
if not match:
    raise SystemExit("Missing frontmatter")
front = match.group(1)
version = None
for line in front.splitlines():
    if line.startswith("version:"):
        version = line.split(":", 1)[1].strip()
        break
if not version:
    raise SystemExit("Missing version in SKILL.md")
print(version)
PY
)

TEMP_DIR=$(mktemp -d)
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

cp -R "$SKILL_DIR" "$TEMP_DIR/$SKILL_NAME"

mkdir -p dist/skills
ZIP_NAME="${SKILL_NAME}-v${VERSION}.zip"
(
  cd "$TEMP_DIR"
  zip -r "$OLDPWD/dist/skills/$ZIP_NAME" "$SKILL_NAME" \
    -x "*.DS_Store" -x "*/.git/*" -x "*/user/context.md" -x "*/.env"
)

ZIP_NAME="$ZIP_NAME" python3 - <<'PY'
import hashlib
from pathlib import Path
import os

zip_path = Path("dist") / "skills" / os.environ["ZIP_NAME"]
sha256 = hashlib.sha256(zip_path.read_bytes()).hexdigest()
(Path("dist") / "skills" / f"{zip_path.name}.sha256").write_text(f"{sha256}  {zip_path.name}\n", encoding="utf-8")
PY

echo "Built: dist/skills/$ZIP_NAME"
