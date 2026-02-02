#!/usr/bin/env bash
set -euo pipefail

for pack_dir in skill-pack/*; do
  if [[ -d "$pack_dir" ]]; then
    pack_name=$(basename "$pack_dir")
    ./scripts/build-pack.sh "$pack_name"
  fi
done

ls -la dist/*.zip
