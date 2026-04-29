#!/usr/bin/env bash
set -euo pipefail
docker compose -f infra/docker-compose/docker-compose.postgres.yml logs --tail=100 "$@"
