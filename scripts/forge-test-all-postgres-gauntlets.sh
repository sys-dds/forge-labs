#!/usr/bin/env bash
set -euo pipefail
for pack in 02-postgres/_gauntlet/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  ./scripts/forge-test-postgres-gauntlet.sh "${pack%/}"
done
printf 'PASS all PostgreSQL gauntlets
'
