#!/usr/bin/env bash
set -euo pipefail

for skill_dir in skills/*; do
  if [[ -d "$skill_dir" ]]; then
    skill_name=$(basename "$skill_dir")
    ./scripts/build-skill.sh "$skill_name"
  fi
done
