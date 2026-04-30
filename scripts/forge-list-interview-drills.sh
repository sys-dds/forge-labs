#!/usr/bin/env bash
set -euo pipefail

printf 'SQL interview drills\n'
for drill in 01-sql/_interview-drills/[0-9][0-9]-*/; do
  [[ -d "$drill" ]] || continue
  printf '%s\n  prompt: %s/prompt.md\n' "${drill%/}" "${drill%/}"
done
