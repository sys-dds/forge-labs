#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

reset_public_schema() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;"
}

clinic_path="${1:-}"
if [[ -z "$clinic_path" || ! -d "$clinic_path" ]]; then
  echo "usage: $0 01-sql-redone/02-feed-candidates-and-joins" >&2
  exit 2
fi

reset_public_schema
echo "Loading broken SQL redone clinic $clinic_path"
for sql_file in 01-schema.sql 02-seed.sql 03-broken-query.sql; do
  [[ -f "$clinic_path/$sql_file" ]] || { echo "FAIL missing $clinic_path/$sql_file" >&2; exit 1; }
  echo "  -> $clinic_path/$sql_file"
  "${psql_base[@]}" -f - < "$clinic_path/$sql_file"
done
echo "PASS loaded broken clinic for inspection: $clinic_path"

