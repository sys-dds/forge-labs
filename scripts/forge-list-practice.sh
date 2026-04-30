#!/usr/bin/env bash
set -euo pipefail

practice_root="01-sql/_practice"

if [[ ! -d "$practice_root" ]]; then
  echo "FAIL missing practice root: $practice_root" >&2
  exit 1
fi

printf 'SQL practice packs\n'
for manifest in "$practice_root"/[0-9][0-9]-*/challenge.manifest; do
  [[ -f "$manifest" ]] || continue
  id=$(awk -F= '$1=="id"{print substr($0, index($0,$2))}' "$manifest")
  title=$(awk -F= '$1=="title"{print substr($0, index($0,$2))}' "$manifest")
  source=$(awk -F= '$1=="source_chapter"{print substr($0, index($0,$2))}' "$manifest")
  printf '%s\n  id: %s\n  title: %s\n  source: %s\n' "$(dirname "$manifest")" "$id" "$title" "$source"
done
