#!/usr/bin/env bash
set -euo pipefail

printf 'SQL self-assessment files\n'
for file in 01-sql/_self-assessment/*.md; do
  [[ -f "$file" ]] && printf -- '- %s\n' "$file"
done
