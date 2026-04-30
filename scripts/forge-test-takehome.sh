#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)

pack="${1:-}"
if [[ -z "$pack" ]]; then
  echo "usage: $0 01-sql/_takehomes/01-social-feed-takehome" >&2
  exit 2
fi
[[ -d "$pack" && -f "$pack/00-brief.md" ]] || { echo "FAIL invalid take-home: $pack" >&2; exit 1; }

"${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;' >/dev/null
printf 'Testing take-home %s\n' "$pack"
for file in 01-schema.sql 02-seed.sql 04-solution.sql 05-proof.tests.sql; do
  printf '  -> %s/%s\n' "$pack" "$file"
  "${psql_base[@]}" -f - < "$pack/$file"
done
printf 'PASS take-home proof: %s\n' "$pack"
