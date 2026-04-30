#!/usr/bin/env bash
set -euo pipefail

for pack in 01-sql/_gauntlet/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  ./scripts/forge-test-gauntlet.sh "${pack%/}"
done
printf 'PASS all SQL gauntlets\n'
