#!/usr/bin/env bash
set -euo pipefail
compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
reset_postgres_db() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; DROP SCHEMA IF EXISTS app CASCADE; DROP SCHEMA IF EXISTS audit CASCADE; DROP SCHEMA IF EXISTS internal CASCADE; DROP SCHEMA IF EXISTS demo CASCADE; CREATE SCHEMA public;"
}

pack_path="${1:-}"
if [[ -z "$pack_path" || ! -f "$pack_path/gauntlet.manifest" ]]; then
  echo "usage: $0 02-postgres/_gauntlet/01-broken-upsert-idempotency" >&2
  exit 2
fi
printf 'Testing PostgreSQL gauntlet %s
' "$pack_path"
reset_postgres_db
for sql_file in 01-schema.sql 02-seed.sql 03-broken-query.sql 05-proof.tests.sql; do
  printf '  -> broken %s/%s
' "$pack_path" "$sql_file"
  if [[ "$sql_file" == "05-proof.tests.sql" ]]; then
    if "${psql_base[@]}" -f - < "$pack_path/$sql_file"; then
      echo "FAIL broken implementation passed proof: $pack_path" >&2
      exit 1
    fi
  else
    "${psql_base[@]}" -f - < "$pack_path/$sql_file"
  fi
done
reset_postgres_db
for sql_file in 01-schema.sql 02-seed.sql 04-solution.sql 05-proof.tests.sql; do
  printf '  -> fixed %s/%s
' "$pack_path" "$sql_file"
  "${psql_base[@]}" -f - < "$pack_path/$sql_file"
done
printf 'PASS PostgreSQL gauntlet proof: %s
' "$pack_path"
