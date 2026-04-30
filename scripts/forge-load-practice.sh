#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

pack_path="${1:-}"
if [[ -z "$pack_path" ]]; then
  echo "usage: $0 01-sql/_practice/01-social-graph-suggestions" >&2
  exit 2
fi
if [[ ! -d "$pack_path" || ! -f "$pack_path/challenge.manifest" ]]; then
  echo "FAIL invalid practice pack: $pack_path" >&2
  exit 1
fi

"${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
printf 'Loading practice pack %s\n' "$pack_path"
for sql_file in 01-schema.sql 02-seed.sql 03-starting-point.sql; do
  if [[ ! -f "$pack_path/$sql_file" ]]; then
    echo "FAIL missing $pack_path/$sql_file" >&2
    exit 1
  fi
  printf '  -> %s/%s\n' "$pack_path" "$sql_file"
  "${psql_base[@]}" -f - < "$pack_path/$sql_file"
done
printf 'PASS practice pack loaded: %s\n' "$pack_path"
printf 'Inspect it in Adminer at http://localhost:8081 or DbGate at http://localhost:8082\n'
