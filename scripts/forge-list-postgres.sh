#!/usr/bin/env bash
set -euo pipefail
for chapter in 02-postgres/[0-9][0-9]-*/; do
  [[ -d "$chapter" ]] || continue
  title=$(head -n 1 "$chapter/README.md" | sed 's/^# //')
  printf '%s | %s
' "${chapter%/}" "$title"
done
