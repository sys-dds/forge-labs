#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
started=0

cleanup() {
  if [[ "$started" == "1" ]]; then
    docker compose -f "$compose_file" down -v
  fi
}
trap cleanup EXIT

section() {
  printf '\n== %s ==\n' "$1"
}

section "Docker config"
docker compose -f "$compose_file" config >/dev/null

section "Docker up"
docker compose -f "$compose_file" up -d
started=1

section "SQL chapters"
./scripts/run-all-sql-chapters.sh

section "Workshop quality"
./scripts/check-workshop-quality.sh

if [[ -x ./scripts/forge-list-practice.sh ]]; then
  section "Practice packs"
  ./scripts/forge-list-practice.sh
  for pack in 01-sql/_practice/[0-9][0-9]-*/; do
    [[ -d "$pack" ]] && ./scripts/forge-test-practice.sh "${pack%/}"
  done
fi

section "Gauntlets"
./scripts/forge-list-gauntlet.sh
./scripts/forge-test-all-gauntlets.sh

section "Take-homes"
./scripts/forge-list-takehomes.sh
./scripts/forge-test-all-takehomes.sh

section "Docker down"
docker compose -f "$compose_file" down -v
started=0

printf '\nPASS SQL mastery verification\n'
