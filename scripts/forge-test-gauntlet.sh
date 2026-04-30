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

reset_db() {
  "${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;' >/dev/null
}
run_file() {
  local file="$1"
  printf '  -> %s\n' "$file"
  "${psql_base[@]}" -f - < "$file"
}

printf 'Testing gauntlet broken query should fail: %s\n' "$pack"
reset_db
run_file "$pack/01-schema.sql"
run_file "$pack/02-seed.sql"
run_file "$pack/03-broken-query.sql"
if "${psql_base[@]}" -f - < "$pack/05-proof.tests.sql" >/tmp/forge-gauntlet-broken.out 2>&1; then
  cat /tmp/forge-gauntlet-broken.out >&2
  echo "FAIL broken query unexpectedly passed proof: $pack" >&2
  exit 1
fi
printf '  -> broken query failed proof as expected\n'

printf 'Testing gauntlet solution should pass: %s\n' "$pack"
reset_db
run_file "$pack/01-schema.sql"
run_file "$pack/02-seed.sql"
run_file "$pack/04-solution.sql"
run_file "$pack/05-proof.tests.sql"
printf 'PASS gauntlet proof: %s\n' "$pack"
