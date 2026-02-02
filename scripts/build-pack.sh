#!/usr/bin/env bash
set -euo pipefail

PACK_NAME="${1:-}"
if [[ -z "$PACK_NAME" ]]; then
  echo "Usage: ./scripts/build-pack.sh <pack-name>" >&2
  exit 1
fi

PACK_DIR="skill-pack/$PACK_NAME"
PACK_FILE="$PACK_DIR/PACK.md"
if [[ ! -f "$PACK_FILE" ]]; then
  echo "Pack file not found: $PACK_FILE" >&2
  exit 1
fi

VERSION=$(PACK_NAME="$PACK_NAME" python3 - <<'PY'
import re
from pathlib import Path
import os
pack = Path("skill-pack") / Path(os.environ["PACK_NAME"]) / "PACK.md"
text = pack.read_text(encoding="utf-8")
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
    raise SystemExit("Missing version in PACK.md")
print(version)
PY
)

SKILLS=$(PACK_NAME="$PACK_NAME" python3 - <<'PY'
import re
from pathlib import Path
import os
pack = Path("skill-pack") / Path(os.environ["PACK_NAME"]) / "PACK.md"
text = pack.read_text(encoding="utf-8")
match = re.search(r"^---\n(.*?)\n---\n", text, re.S)
if not match:
    raise SystemExit("Missing frontmatter")
front = match.group(1)
lines = front.splitlines()
skills = []
in_skills = False
for line in lines:
    if line.startswith("skills:"):
        in_skills = True
        continue
    if in_skills:
        if re.match(r"^[a-zA-Z_].*:\s*", line):
            break
        m = re.match(r"\s*-\s*(.+)", line)
        if m:
            skills.append(m.group(1).strip())
if not skills:
    raise SystemExit("No skills listed in PACK.md")
print(" ".join(skills))
PY
)

TEMP_DIR=$(mktemp -d)
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

if [[ -f "$PACK_DIR/README.md" ]]; then
  cp "$PACK_DIR/README.md" "$TEMP_DIR/README.md"
fi
cp "$PACK_FILE" "$TEMP_DIR/PACK.md"

for SKILL in $SKILLS; do
  if [[ ! -d "skills/$SKILL" ]]; then
    echo "Skill not found: skills/$SKILL" >&2
    exit 1
  fi
  cp -R "skills/$SKILL" "$TEMP_DIR/$SKILL"
done

mkdir -p dist
ZIP_NAME="${PACK_NAME}-v${VERSION}.zip"
(
  cd "$TEMP_DIR"
  zip -r "$OLDPWD/dist/$ZIP_NAME" . \
    -x "*.DS_Store" -x "*/.git/*" -x "*/user/context.md" -x "*/.env"
)

ZIP_NAME="$ZIP_NAME" python3 - <<'PY'
import hashlib
from pathlib import Path
import os

zip_path = Path("dist") / os.environ["ZIP_NAME"]
sha256 = hashlib.sha256(zip_path.read_bytes()).hexdigest()
(Path("dist") / f"{zip_path.name}.sha256").write_text(f"{sha256}  {zip_path.name}\\n", encoding="utf-8")
PY

echo "Built: dist/$ZIP_NAME"
