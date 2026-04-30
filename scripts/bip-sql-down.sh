#!/usr/bin/env bash
set -euo pipefail
docker compose -f infra/docker-compose/docker-compose.postgres.yml down
echo "PASS BIP SQL Postgres stopped"
