#!/usr/bin/env bash
set -euo pipefail

pack_path="${1:-}"
if [[ -z "$pack_path" ]]; then
  echo "usage: $0 01-sql/_practice/01-social-graph-suggestions" >&2
  exit 2
fi
if [[ ! -d "$pack_path" || ! -f "$pack_path/challenge.manifest" ]]; then
  echo "FAIL invalid practice pack: $pack_path" >&2
  exit 1
fi

printf 'Challenge path: %s\n\n' "$pack_path"
printf 'Manifest\n'
sed -n '1,160p' "$pack_path/challenge.manifest"
printf '\nScenario\n'
sed -n '1,180p' "$pack_path/00-scenario.md"
printf '\nFiles in reading order\n'
for file in README.md challenge.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-starting-point.sql 04-solution.sql 05-proof.tests.sql 06-expected-results.md 07-break-fix-drills.md 08-interview-explanation.md; do
  [[ -f "$pack_path/$file" ]] && printf -- '- %s/%s\n' "$pack_path" "$file"
done
printf '\nExpected results: %s/06-expected-results.md\n' "$pack_path"
printf 'Break/fix drills: %s/07-break-fix-drills.md\n' "$pack_path"
printf 'Inspect loaded data in Adminer at http://localhost:8081 or DbGate at http://localhost:8082\n'
