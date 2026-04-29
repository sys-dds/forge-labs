#!/usr/bin/env bash
set -euo pipefail

compose_file="infra/docker-compose/docker-compose.postgres.yml"
service="forge-labs-postgres"
psql_base=(docker compose -f "$compose_file" exec -T "$service" psql -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
chapter_required() {
  local chapter_path="${1:-}"
  if [[ -z "$chapter_path" ]]; then
    echo "usage: $0 01-sql/04-followers-and-social-graph" >&2
    exit 2
  fi
  if [[ ! -d "$chapter_path" || "$chapter_path" == *"_template"* ]]; then
    echo "FAIL invalid chapter: $chapter_path" >&2
    exit 1
  fi
}
reset_db() {
  "${psql_base[@]}" -c 'DROP SCHEMA public CASCADE; CREATE SCHEMA public;'
}
load_solutions() {
  local chapter_path="$1"
  while IFS= read -r sql_file; do
    printf '  -> %s\n' "$sql_file"
    "${psql_base[@]}" -f - < "$sql_file"
  done < <(find "$chapter_path" -maxdepth 1 -type f -name '*.solution.sql' | sort)
}
run_proof() {
  local chapter_path="$1"
  local proof_file="$chapter_path/99-chapter-proof.tests.sql"
  if [[ ! -f "$proof_file" ]]; then
    echo "FAIL missing proof: $proof_file" >&2
    exit 1
  fi
  printf '  -> %s\n' "$proof_file"
  "${psql_base[@]}" -f - < "$proof_file"
}
chapter_path="${1:-}"
chapter_required "$chapter_path"
printf 'Testing chapter %s\n' "$chapter_path"
reset_db
load_solutions "$chapter_path"
run_proof "$chapter_path"
printf 'PASS %s\n' "$chapter_path"
