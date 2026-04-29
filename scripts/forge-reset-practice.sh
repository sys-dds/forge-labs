#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

"${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
printf 'PASS practice database reset\n'
