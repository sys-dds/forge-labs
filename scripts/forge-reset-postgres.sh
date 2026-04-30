#!/usr/bin/env bash
set -euo pipefail
compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
reset_postgres_db() {
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS public CASCADE; DROP SCHEMA IF EXISTS app CASCADE; DROP SCHEMA IF EXISTS audit CASCADE; DROP SCHEMA IF EXISTS internal CASCADE; DROP SCHEMA IF EXISTS demo CASCADE; CREATE SCHEMA public;"
}

reset_postgres_db
printf 'PASS forge_labs PostgreSQL schemas reset
'
