#!/usr/bin/env bash
set -euo pipefail

shopt -s nullglob
declare -A seen=()

for skill_dir in skill-packs/*/* skills/*; do
  if [[ -d "$skill_dir" ]]; then
    skill_name=$(basename "$skill_dir")
    if [[ -z "${seen[$skill_name]+x}" ]]; then
      seen[$skill_name]=1
      ./scripts/build-skill.sh "$skill_name"
    fi
  fi
done
