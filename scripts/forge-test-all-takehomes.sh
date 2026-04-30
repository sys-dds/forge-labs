#!/usr/bin/env bash
set -euo pipefail

for pack in 01-sql/_takehomes/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  ./scripts/forge-test-takehome.sh "${pack%/}"
done
printf 'PASS all SQL take-homes\n'
