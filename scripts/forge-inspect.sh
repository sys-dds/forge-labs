#!/usr/bin/env bash
set -euo pipefail
chapter_path="${1:-}"
if [[ -z "$chapter_path" ]]; then
  echo "usage: $0 01-sql/04-followers-and-social-graph" >&2
  exit 2
fi
if [[ ! -d "$chapter_path" || "$chapter_path" == *"_template"* ]]; then
  echo "FAIL invalid chapter: $chapter_path" >&2
  exit 1
fi
printf 'Chapter path: %s

' "$chapter_path"
printf 'Files in reading order:
'
for file in README.md 00-dataset.story.md 00-concept.explainer.md; do
  [[ -f "$chapter_path/$file" ]] && printf '  - %s
' "$chapter_path/$file"
done
find "$chapter_path" -maxdepth 1 -type f -name '*.solution.sql' | sort | sed 's/^/  - /'
for file in 99-chapter-proof.tests.sql 90-common-mistakes.sql 91-common-mistakes.explainer.md 98-extension-tasks.md; do
  [[ -f "$chapter_path/$file" ]] && printf '  - %s
' "$chapter_path/$file"
done
printf '
Solution files in execution order:
'
find "$chapter_path" -maxdepth 1 -type f -name '*.solution.sql' | sort | sed 's/^/  - /'
printf '
Proof file:
  - %s/99-chapter-proof.tests.sql
' "$chapter_path"
printf '
Dataset story file:
  - %s/00-dataset.story.md
' "$chapter_path"
printf '
Study UI connection info:
'
printf '  - Adminer: http://localhost:8081
'
printf '  - DbGate: http://localhost:8082
'
printf '  - PostgreSQL server inside compose network: forge-labs-postgres
'
printf '  - Database/user/password: forge_labs / forge_labs / forge_labs
'
