#!/usr/bin/env bash
set -euo pipefail
compose_file="infra/docker-compose/docker-compose.postgres.yml"
started=0
if ! docker compose -f "$compose_file" ps --status running forge-labs-postgres >/dev/null 2>&1; then
  docker compose -f "$compose_file" up -d
  started=1
fi
cleanup(){
  if [[ "$started" -eq 1 ]]; then
    docker compose -f "$compose_file" down -v
  fi
}
trap cleanup EXIT
printf '== Docker compose config ==
'
docker compose -f "$compose_file" config >/dev/null
printf 'PASS docker compose config
'
printf '== PostgreSQL chapters ==
'
./scripts/forge-test-all-postgres.sh
printf '== PostgreSQL practice packs ==
'
./scripts/forge-test-all-postgres-practice.sh
printf '== PostgreSQL gauntlets ==
'
./scripts/forge-test-all-postgres-gauntlets.sh
printf '== PostgreSQL quality gate ==
'
./scripts/check-postgres-quality.sh
printf 'PASS PostgreSQL local verification
'
