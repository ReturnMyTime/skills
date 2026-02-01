#!/usr/bin/env bash
set -euo pipefail

for pack_dir in skill-pack/*; do
  if [[ -d "$pack_dir" ]]; then
    pack_name=$(basename "$pack_dir")
    ./scripts/build-pack.sh "$pack_name"
  fi
done

python3 - <<'PY'
import hashlib
import json
from pathlib import Path

dist = Path("dist")
manifest = []
for zip_path in sorted(dist.glob("*.zip")):
    sha256 = hashlib.sha256(zip_path.read_bytes()).hexdigest()
    manifest.append({
        "file": zip_path.name,
        "sha256": sha256,
    })

(dist / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
print("Wrote dist/manifest.json")
PY

ls -la dist/*.zip
