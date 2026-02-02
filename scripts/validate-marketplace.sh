#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ROOT_DIR

python3 - <<'PY'
import json
import os
from pathlib import Path

root = Path(os.environ["ROOT_DIR"]).resolve()
path = root / ".claude-plugin" / "marketplace.json"

if not path.exists():
    raise SystemExit("marketplace.json not found. Run scripts/generate-marketplace.sh first.")

marketplace = json.loads(path.read_text(encoding="utf-8"))

errors = []
required_top = ["name", "owner", "metadata", "plugins"]
for key in required_top:
    if key not in marketplace:
        errors.append(f"Missing top-level key: {key}")

owner = marketplace.get("owner", {})
for key in ("name", "email"):
    if key not in owner or not owner.get(key):
        errors.append(f"Missing owner.{key}")

metadata = marketplace.get("metadata", {})
for key in ("description", "version"):
    if key not in metadata or not metadata.get(key):
        errors.append(f"Missing metadata.{key}")

plugins = marketplace.get("plugins", [])
if not isinstance(plugins, list) or not plugins:
    errors.append("plugins must be a non-empty list")

seen = set()
for plugin in plugins:
    for key in ("name", "source", "description", "version", "category", "tags", "strict", "skills"):
        if key not in plugin:
            errors.append(f"Plugin missing {key}: {plugin}")
    name = plugin.get("name")
    if name in seen:
        errors.append(f"Duplicate plugin name: {name}")
    seen.add(name)

    tags = plugin.get("tags", [])
    if not isinstance(tags, list) or len(tags) < 1:
        errors.append(f"Plugin {name} must have at least one tag")

    skills = plugin.get("skills", [])
    if not isinstance(skills, list) or len(skills) < 1:
        errors.append(f"Plugin {name} must include skills")
    else:
        for skill_path in skills:
            skill_path = str(skill_path)
            if skill_path.startswith("./"):
                skill_path = skill_path[2:]
            if not (root / skill_path).exists():
                errors.append(f"Plugin {name} skill path missing: {skill_path}")

if errors:
    raise SystemExit("\n".join(errors))

print("marketplace.json is valid")
PY
