#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"

cleanup() {
  docker compose -f "$compose_file" down -v >/dev/null 2>&1 || true
}
trap cleanup EXIT

if ! docker info >/dev/null 2>&1; then
  echo "FAIL Docker is unavailable or the daemon is not running" >&2
  exit 1
fi

docker compose -f "$compose_file" config >/dev/null
docker compose -f "$compose_file" up -d
./scripts/forge-list-sql-redone.sh
./scripts/forge-inspect-sql-redone.sh 01-sql-redone/10-sql-endpoint-capstone >/dev/null
./scripts/forge-test-all-sql-redone.sh
./scripts/check-sql-redone-quality.sh
docker compose -f "$compose_file" down -v
trap - EXIT
echo "PASS SQL redone verification"
