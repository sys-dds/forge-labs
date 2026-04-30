#!/usr/bin/env bash
set -euo pipefail

pack="${1:-}"
if [[ -z "$pack" ]]; then
  echo "usage: $0 01-sql/_gauntlet/01-feed-candidate-query-clinic" >&2
  exit 2
fi
[[ -d "$pack" && -f "$pack/gauntlet.manifest" ]] || { echo "FAIL invalid gauntlet pack: $pack" >&2; exit 1; }

printf 'Gauntlet path: %s\n\n' "$pack"
printf 'Manifest\n'
sed -n '1,180p' "$pack/gauntlet.manifest"
printf '\nScenario\n'
sed -n '1,160p' "$pack/00-scenario.md"
printf '\nFiles in repair order\n'
for file in README.md gauntlet.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-broken-query.sql 04-solution.sql 05-proof.tests.sql 06-debugging-notes.md 07-break-fix-drills.md 08-interview-explanation.md; do
  [[ -f "$pack/$file" ]] && printf -- '- %s/%s\n' "$pack" "$file"
done
printf '\nInspect loaded data in Adminer at http://localhost:8081 or DbGate at http://localhost:8082\n'
