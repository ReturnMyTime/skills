#!/usr/bin/env bash
set -euo pipefail

./scripts/generate-marketplace.sh
./scripts/build-all-packs.sh
./scripts/build-all-skills.sh

python3 - <<'PY'
import hashlib
import json
import re
from datetime import datetime, timezone
from pathlib import Path

artifacts = []

def add_artifact(path: Path, kind: str):
    name_version = path.stem
    match = re.match(r"^(?P<name>.+)-v(?P<version>[0-9]+\.[0-9]+\.[0-9]+)$", name_version)
    if not match:
        name = name_version
        version = "unknown"
    else:
        name = match.group("name")
        version = match.group("version")
    sha256 = hashlib.sha256(path.read_bytes()).hexdigest()
    artifacts.append({
        "type": kind,
        "name": name,
        "version": version,
        "file": str(path.relative_to(Path("dist"))),
        "sha256": sha256,
        "sizeBytes": path.stat().st_size,
    })

for zip_path in sorted(Path("dist").glob("*.zip")):
    add_artifact(zip_path, "pack")

for zip_path in sorted(Path("dist/skills").glob("*.zip")):
    add_artifact(zip_path, "skill")

mana = {
    "schemaVersion": "1.0.0",
    "generatedAt": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    "artifacts": artifacts,
}

Path("dist").mkdir(parents=True, exist_ok=True)
Path("dist/mana-spec.json").write_text(json.dumps(mana, indent=2) + "\n", encoding="utf-8")
print("Wrote dist/mana-spec.json")
PY
