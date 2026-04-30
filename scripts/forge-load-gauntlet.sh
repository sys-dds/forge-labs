#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

pack="${1:-}"
if [[ -z "$pack" ]]; then
  echo "usage: $0 01-sql/_gauntlet/01-feed-candidate-query-clinic" >&2
  exit 2
fi
[[ -d "$pack" && -f "$pack/gauntlet.manifest" ]] || { echo "FAIL invalid gauntlet pack: $pack" >&2; exit 1; }

"${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
printf 'Loading gauntlet broken state %s\n' "$pack"
for file in 01-schema.sql 02-seed.sql 03-broken-query.sql; do
  [[ -f "$pack/$file" ]] || { echo "FAIL missing $pack/$file" >&2; exit 1; }
  printf '  -> %s/%s\n' "$pack" "$file"
  "${psql_base[@]}" -f - < "$pack/$file"
done
printf 'PASS gauntlet loaded with broken query: %s\n' "$pack"
