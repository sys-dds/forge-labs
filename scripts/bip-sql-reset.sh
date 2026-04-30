#!/usr/bin/env bash
set -euo pipefail
clinic="${1:-}"
if [[ -z "$clinic" || ! -d "$clinic" ]]; then echo "usage: $0 <clinic-dir>" >&2; exit 2; fi
name="$(basename "$clinic")"
num="${name%%-*}"
schema="bip_sql_$num"
docker compose -f infra/docker-compose/docker-compose.postgres.yml exec -T forge-labs-postgres psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs -c "DROP SCHEMA IF EXISTS $schema CASCADE; CREATE SCHEMA $schema;" >/dev/null
echo "PASS reset $schema"
