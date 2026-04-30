#!/usr/bin/env bash
set -euo pipefail
chapter_path="${1:-}"
if [[ -z "$chapter_path" || ! -d "$chapter_path" ]]; then
  echo "usage: $0 02-postgres/06-insert-on-conflict-idempotent-writes" >&2
  exit 2
fi
printf 'Chapter path: %s

' "$chapter_path"
for file in README.md 00-concept.explainer.md 00-dataset.story.md 01-schema.sql 02-seed.sql 03-demo.sql 04-solution.sql 05-proof.tests.sql 90-common-mistakes.sql 91-common-mistakes.explainer.md 98-extension-tasks.md; do
  [[ -f "$chapter_path/$file" ]] || { echo "FAIL missing $chapter_path/$file" >&2; exit 1; }
  printf '%s/%s
' "$chapter_path" "$file"
done
cat <<'NOTE'

Connection reminder:
- Adminer: http://localhost:8081
- DbGate: http://localhost:8082
- database/user/password: forge_labs / forge_labs / forge_labs
NOTE
