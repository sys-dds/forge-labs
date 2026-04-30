#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

reset_public_schema() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;" >/dev/null
}

run_sql() {
  local clinic_path="$1"
  local sql_file="$2"
  [[ -f "$clinic_path/$sql_file" ]] || { echo "FAIL missing $clinic_path/$sql_file" >&2; exit 1; }
  echo "  -> $clinic_path/$sql_file"
  "${psql_base[@]}" -f - < "$clinic_path/$sql_file"
}

clinic_path="${1:-}"
if [[ -z "$clinic_path" || ! -d "$clinic_path" ]]; then
  echo "usage: $0 01-sql-redone/02-feed-candidates-and-joins" >&2
  exit 2
fi

echo "Testing broken path for $clinic_path"
reset_public_schema
run_sql "$clinic_path" 01-schema.sql
run_sql "$clinic_path" 02-seed.sql
run_sql "$clinic_path" 03-broken-query.sql
if "${psql_base[@]}" -f - < "$clinic_path/05-proof.tests.sql"; then
  echo "FAIL broken query unexpectedly passed: $clinic_path" >&2
  exit 1
else
  echo "PASS broken query failed proof as expected"
fi

echo "Testing solution path for $clinic_path"
reset_public_schema
run_sql "$clinic_path" 01-schema.sql
run_sql "$clinic_path" 02-seed.sql
run_sql "$clinic_path" 04-solution.sql
run_sql "$clinic_path" 05-proof.tests.sql
echo "PASS SQL redone clinic proof: $clinic_path"

