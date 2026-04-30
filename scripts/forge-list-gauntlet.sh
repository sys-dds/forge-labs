#!/usr/bin/env bash
set -euo pipefail

root="01-sql/_gauntlet"
[[ -d "$root" ]] || { echo "FAIL missing gauntlet root: $root" >&2; exit 1; }

printf 'SQL gauntlet packs\n'
for manifest in "$root"/[0-9][0-9]-*/gauntlet.manifest; do
  [[ -f "$manifest" ]] || continue
  id=$(awk -F= '$1=="id"{print substr($0, index($0,$2))}' "$manifest")
  title=$(awk -F= '$1=="title"{print substr($0, index($0,$2))}' "$manifest")
  bug=$(awk -F= '$1=="bug_type"{print substr($0, index($0,$2))}' "$manifest")
  source=$(awk -F= '$1=="source_chapter"{print substr($0, index($0,$2))}' "$manifest")
  printf '%s\n  id: %s\n  title: %s\n  bug: %s\n  source: %s\n' "$(dirname "$manifest")" "$id" "$title" "$bug" "$source"
done
