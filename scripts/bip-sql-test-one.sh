#!/usr/bin/env bash
set -euo pipefail
clinic="${1:-}"
if [[ -z "$clinic" || ! -d "$clinic" ]]; then echo "usage: $0 04-backend-interview-patterns-redone/01-sql-interview-patterns/001-filtering-ordering-null-traps" >&2; exit 2; fi
required=(README.md 00-pattern.md 01-schema.sql 02-seed.sql 02b-seed-variant.sql 03-question.md 04-broken-attempt.sql 05-solution.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-proof.sh 08-explain-in-interview.md 09-follow-up-variants.md 10-shortcut-audit.md)
for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || { echo "FAIL missing or empty $clinic/$f" >&2; exit 1; }; done
name="$(basename "$clinic")"; num="${name%%-*}"; schema="bip_sql_$num"
compose=(docker compose -f infra/docker-compose/docker-compose.postgres.yml)
psql_base=("${compose[@]}" exec -T forge-labs-postgres psql -X -q -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
tmpdir="$(mktemp -d /tmp/bip-sql-test.XXXXXX)"
cleanup(){ rm -rf "$tmpdir"; }
trap cleanup EXIT
if grep -Eiq "where[[:space:][:alnum:]_\.]*_id[[:space:]]+in[[:space:]]*\(|order[[:space:]]+by[[:space:]]+case[[:space:]][[:alnum:]_\.]*_id|select[[:space:]]+'[^']+'[[:space:]]+as|expected_output|expected-output" "$clinic/05-solution.sql"; then
  echo "FAIL solution contains hard-coded answer or expected-output shortcut: $clinic" >&2; exit 1
fi
run_case(){
  local seed_file="$1" expected_file="$2" actual_file="$3"
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS $schema CASCADE; CREATE SCHEMA $schema;" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/01-schema.sql" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/$seed_file" >/dev/null
  "${psql_base[@]}" --csv -f - < "$clinic/05-solution.sql" > "$actual_file"
  diff -u "$clinic/$expected_file" "$actual_file"
}
run_broken(){
  local actual_file="$tmpdir/broken.csv"
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS $schema CASCADE; CREATE SCHEMA $schema;" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/01-schema.sql" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/02-seed.sql" >/dev/null
  if "${psql_base[@]}" --csv -f - < "$clinic/04-broken-attempt.sql" > "$actual_file"; then
    if diff -q "$clinic/06-expected-output.csv" "$actual_file" >/dev/null; then
      echo "FAIL broken attempt unexpectedly matched expected output: $clinic" >&2; exit 1
    fi
  else
    echo "PASS broken attempt errored as expected"
    return
  fi
  echo "PASS broken attempt did not match expected output"
}
echo "Testing base solution for $clinic"
run_case 02-seed.sql 06-expected-output.csv "$tmpdir/base.csv"
echo "Testing variant solution for $clinic"
run_case 02b-seed-variant.sql 06b-expected-output-variant.csv "$tmpdir/variant.csv"
run_broken
echo "PASS BIP SQL clinic proof: $clinic"
