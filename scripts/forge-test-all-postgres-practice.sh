#!/usr/bin/env bash
set -euo pipefail
for pack in 02-postgres/_practice/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  ./scripts/forge-test-postgres-practice.sh "${pack%/}"
done
printf 'PASS all PostgreSQL practice packs
'
