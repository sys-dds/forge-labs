#!/usr/bin/env bash
set -euo pipefail
for chapter in 02-postgres/[0-9][0-9]-*/; do
  [[ -d "$chapter" ]] || continue
  ./scripts/forge-test-postgres.sh "${chapter%/}"
done
printf 'PASS all PostgreSQL chapters
'
