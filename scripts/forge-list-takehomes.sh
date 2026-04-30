#!/usr/bin/env bash
set -euo pipefail

root="01-sql/_takehomes"
[[ -d "$root" ]] || { echo "FAIL missing take-home root: $root" >&2; exit 1; }

printf 'SQL mini take-homes\n'
for pack in "$root"/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  title=$(sed -n '1s/^# //p' "$pack/README.md")
  printf '%s\n  title: %s\n' "${pack%/}" "$title"
done
