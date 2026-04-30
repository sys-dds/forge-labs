#!/usr/bin/env bash
set -euo pipefail

clinic_path="${1:-}"
if [[ -z "$clinic_path" || ! -d "$clinic_path" ]]; then
  echo "usage: $0 01-sql-redone/02-feed-candidates-and-joins" >&2
  exit 2
fi

echo "Clinic path: $clinic_path"
echo
echo "Files in reading order:"
for f in README.md 00-design.md 00-scenario.md 01-schema.sql 02-seed.sql 03-broken-query.sql 04-solution.sql 05-proof.tests.sql 06-debugging-notes.md 07-break-fix-drills.md 08-interview-explanation.md 09-what-to-notice.md; do
  [[ -f "$clinic_path/$f" ]] && echo "- $clinic_path/$f"
done
echo
echo "Inspect in Adminer/DbGate:"
echo "- tables created by 01-schema.sql"
echo "- rows inserted by 02-seed.sql"
echo "- broken view/query created by 03-broken-query.sql"
echo "- proof expectations in 05-proof.tests.sql"
echo
echo "Important rows:"
sed -n '/^## Rows To Inspect/,$p' "$clinic_path/README.md" | sed -n '1,20p'
