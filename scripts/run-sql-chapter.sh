#!/usr/bin/env bash
set -euo pipefail

chapter_path="${1:-}"
if [[ -z "$chapter_path" ]]; then
  echo "usage: ./scripts/run-sql-chapter.sh 01-sql/01-tables-and-relationships" >&2
  exit 2
fi

if [[ ! -d "$chapter_path" ]]; then
  echo "FAIL missing chapter: $chapter_path" >&2
  exit 1
fi

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

printf 'Running %s
' "$chapter_path"
"${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'

while IFS= read -r sql_file; do
  printf '  -> %s
' "$sql_file"
  "${psql_base[@]}" -f - < "$sql_file"
done < <(find "$chapter_path" -maxdepth 1 -type f -name '*.solution.sql' | sort)

proof_file="$chapter_path/99-chapter-proof.tests.sql"
if [[ ! -f "$proof_file" ]]; then
  echo "FAIL missing proof: $proof_file" >&2
  exit 1
fi

printf '  -> %s
' "$proof_file"
"${psql_base[@]}" -f - < "$proof_file"
printf 'PASS %s
' "$chapter_path"
