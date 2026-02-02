#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ROOT_DIR

python3 - <<'PY'
import json
import os
import re
import subprocess
from pathlib import Path

root = Path(os.environ["ROOT_DIR"]).resolve()


def git_version() -> str:
    try:
        count_raw = subprocess.check_output(
            ["git", "rev-list", "--count", "HEAD"],
            cwd=root,
            text=True,
        ).strip()
        if not count_raw.isdigit():
            raise ValueError("Non-numeric git count")
        count = int(count_raw)
        dirty = subprocess.check_output(
            ["git", "status", "--porcelain"],
            cwd=root,
            text=True,
        ).strip()
        if dirty:
            count += 1
        return f"0.0.{count}"
    except Exception:
        return "0.0.0"


def parse_frontmatter(text: str) -> dict:
    match = re.search(r"^---\n(.*?)\n---\n", text, re.S)
    if not match:
        return {}
    front = match.group(1)
    data = {}
    lines = front.splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        if re.match(r"^[a-zA-Z_][\w-]*:\s*", line):
            key, val = line.split(":", 1)
            key = key.strip()
            val = val.strip()
            if val in ("|", ">"):
                i += 1
                desc_lines = []
                while i < len(lines) and not re.match(r"^[a-zA-Z_][\w-]*:\s*", lines[i]):
                    desc_lines.append(lines[i].strip())
                    i += 1
                data[key] = " ".join([d for d in desc_lines if d])
                continue
            data[key] = val
        i += 1
    return data


skill_files = []
skill_files.extend(sorted(root.glob("skill-packs/*/*/SKILL.md")))
if (root / "skills").exists():
    skill_files.extend(sorted(root.glob("skills/*/SKILL.md")))

errors = []
plugins = []
seen = set()
version = git_version()

for skill_file in skill_files:
    data = parse_frontmatter(skill_file.read_text(encoding="utf-8"))
    name = data.get("name") or skill_file.parent.name
    description = data.get("description", "").strip()
    category = data.get("category", "").strip()

    if not name:
        errors.append(f"Missing name in {skill_file}")
        continue
    if not description:
        errors.append(f"Missing description in {skill_file}")
        continue
    if not category:
        errors.append(f"Missing category in {skill_file}")
        continue
    if name in seen:
        errors.append(f"Duplicate skill name: {name}")
        continue
    seen.add(name)

    skill_dir = skill_file.parent.relative_to(root).as_posix()

    plugins.append(
        {
            "name": name,
            "source": "./",
            "description": description,
            "version": version,
            "category": category,
            "tags": ["returnmytime"],
            "strict": False,
            "skills": [f"./{skill_dir}"],
        }
    )

if errors:
    raise SystemExit("\n".join(errors))

plugins.sort(key=lambda p: p["name"])

marketplace = {
    "name": "ReturnMyTime/skills",
    "owner": {
        "name": "Return My Time",
        "email": "hello@returnmytime.com",
    },
    "metadata": {
        "description": "Return My Time skills marketplace",
        "version": version,
    },
    "plugins": plugins,
}

out_path = root / ".claude-plugin" / "marketplace.json"
out_path.parent.mkdir(parents=True, exist_ok=True)
out_path.write_text(json.dumps(marketplace, indent=2) + "\n", encoding="utf-8")
print(f"Wrote {out_path}")
PY
