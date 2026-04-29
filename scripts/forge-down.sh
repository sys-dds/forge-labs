#!/usr/bin/env bash
set -euo pipefail
docker compose -f infra/docker-compose/docker-compose.postgres.yml down -v
printf 'PASS forge stack stopped and volumes removed\n'
