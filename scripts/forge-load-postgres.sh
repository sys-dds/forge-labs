#!/usr/bin/env bash
set -euo pipefail
compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
reset_postgres_db() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; DROP SCHEMA IF EXISTS app CASCADE; DROP SCHEMA IF EXISTS audit CASCADE; DROP SCHEMA IF EXISTS internal CASCADE; DROP SCHEMA IF EXISTS demo CASCADE; CREATE SCHEMA public;"
}

chapter_path="${1:-}"
if [[ -z "$chapter_path" || ! -d "$chapter_path" ]]; then
  echo "usage: $0 02-postgres/06-insert-on-conflict-idempotent-writes" >&2
  exit 2
fi
reset_postgres_db
printf 'Loading PostgreSQL chapter %s
' "$chapter_path"
for sql_file in 01-schema.sql 02-seed.sql 03-demo.sql; do
  [[ -f "$chapter_path/$sql_file" ]] || { echo "FAIL missing $chapter_path/$sql_file" >&2; exit 1; }
  printf '  -> %s/%s
' "$chapter_path" "$sql_file"
  "${psql_base[@]}" -f - < "$chapter_path/$sql_file"
done
printf 'PASS loaded %s for inspection
' "$chapter_path"
