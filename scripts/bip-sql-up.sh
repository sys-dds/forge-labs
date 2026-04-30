#!/usr/bin/env bash
set -euo pipefail
docker compose -f infra/docker-compose/docker-compose.postgres.yml up -d forge-labs-postgres
echo "PASS BIP SQL Postgres running at localhost:5432 database=forge_labs user=forge_labs password=forge_labs"
