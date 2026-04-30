#!/usr/bin/env bash
set -euo pipefail

pack="${1:-}"
if [[ -z "$pack" ]]; then
  echo "usage: $0 01-sql/_takehomes/01-social-feed-takehome" >&2
  exit 2
fi
[[ -d "$pack" && -f "$pack/00-brief.md" ]] || { echo "FAIL invalid take-home: $pack" >&2; exit 1; }

printf 'Take-home path: %s\n\n' "$pack"
sed -n '1,180p' "$pack/00-brief.md"
printf '\nFiles in candidate order\n'
for file in README.md 00-brief.md 01-schema.sql 02-seed.sql 03-candidate-task.md 04-solution.sql 05-proof.tests.sql 06-review-rubric.md 07-follow-up-questions.md 08-model-walkthrough.md; do
  [[ -f "$pack/$file" ]] && printf -- '- %s/%s\n' "$pack" "$file"
done
