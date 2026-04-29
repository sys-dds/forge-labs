#!/usr/bin/env bash
set -euo pipefail
target="${1:-postgres}"
if [[ "$target" != "postgres" ]]; then
  echo "usage: ./scripts/forge-shell.sh postgres" >&2
  exit 2
fi
docker compose -f infra/docker-compose/docker-compose.postgres.yml exec forge-labs-postgres psql -U forge_labs -d forge_labs
