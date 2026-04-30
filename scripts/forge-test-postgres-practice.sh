#!/usr/bin/env bash
set -euo pipefail
compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
reset_postgres_db() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; DROP SCHEMA IF EXISTS app CASCADE; DROP SCHEMA IF EXISTS audit CASCADE; DROP SCHEMA IF EXISTS internal CASCADE; DROP SCHEMA IF EXISTS demo CASCADE; CREATE SCHEMA public;"
}

pack_path="${1:-}"
if [[ -z "$pack_path" || ! -f "$pack_path/practice.manifest" ]]; then
  echo "usage: $0 02-postgres/_practice/01-idempotency-key-upsert-clinic" >&2
  exit 2
fi
reset_postgres_db
printf 'Testing PostgreSQL practice pack %s
' "$pack_path"
for sql_file in 01-schema.sql 02-seed.sql 03-starting-point.sql 04-solution.sql 05-proof.tests.sql; do
  printf '  -> %s/%s
' "$pack_path" "$sql_file"
  "${psql_base[@]}" -f - < "$pack_path/$sql_file"
done
printf 'PASS PostgreSQL practice proof: %s
' "$pack_path"
