#!/usr/bin/env bash
set -euo pipefail
mode="${1:-sql}"
if [[ "$mode" != "sql" ]]; then
  echo "usage: ./scripts/forge-up.sh sql" >&2
  exit 2
fi
docker compose -f infra/docker-compose/docker-compose.postgres.yml up -d
printf 'PASS sql study stack running\n'
printf 'Postgres: localhost:5432 database=forge_labs user=forge_labs password=forge_labs\n'
printf 'Adminer:  http://localhost:8081\n'
printf 'DbGate:   http://localhost:8082\n'
