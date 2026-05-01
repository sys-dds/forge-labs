#!/usr/bin/env bash
set -euo pipefail
clinic="${1:-}"
if [[ -z "$clinic" || ! -d "$clinic" ]]; then echo "usage: $0 05-banking-systems-redone/001-accounts-balances-available-vs-actual" >&2; exit 2; fi
required=(README.md 00-interview-question.md 01-data-model.md 02-schema.sql 03-seed.sql 03b-seed-variant.sql 04-core-queries.sql 05-verification-query.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-broken-model-or-query.sql 08-proof.sh 09-api-shape.md 10-read-write-path.md 11-correctness-notes.md 12-common-mistakes.md 13-how-to-explain-in-interview.md 14-shortcut-audit.md)
for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || { echo "FAIL missing or empty $clinic/$f" >&2; exit 1; }; done
name="$(basename "$clinic")"; num="${name%%-*}"; schema="bank_r2_$num"
compose=(docker compose -f infra/docker-compose/docker-compose.postgres.yml)
psql_base=("${compose[@]}" exec -T forge-labs-postgres psql -X -q -v ON_ERROR_STOP=1 -U forge_labs -d forge_labs)
tmpdir="$(mktemp -d /tmp/bank-r2-test.XXXXXX)"
cleanup(){ rm -rf "$tmpdir"; }
trap cleanup EXIT
if grep -Eiq "where[[:space:][:alnum:]_\.]*_id[[:space:]]+in[[:space:]]*\(|order[[:space:]]+by[[:space:]]+case[[:space:]][[:alnum:]_\.]*_id|expected_output|expected-output|create[[:space:]]+(temporary[[:space:]]+|temp[[:space:]]+)?table[[:space:]]+(answer|expected|result)|from[[:space:]]+(answer|expected|result)" "$clinic/05-verification-query.sql"; then
  echo "FAIL verification query contains shortcut pattern: $clinic" >&2; exit 1
fi
if grep -Eiq "select[[:space:]]+'[^']+'[[:space:]]+as[[:space:]]+contract_name[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]+as[[:space:]]+subject_id[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then
  echo "FAIL verification query appears to emit literal answer rows: $clinic" >&2; exit 1
fi
run_case(){
  local seed_file="$1" expected_file="$2" actual_file="$3"
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS $schema CASCADE; CREATE SCHEMA $schema;" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/02-schema.sql" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/$seed_file" >/dev/null
  "${psql_base[@]}" --csv -f - < "$clinic/05-verification-query.sql" > "$actual_file"
  diff -u "$clinic/$expected_file" "$actual_file"
}
run_broken(){
  local actual_file="$tmpdir/broken.csv"
  "${psql_base[@]}" -c "DROP SCHEMA IF EXISTS $schema CASCADE; CREATE SCHEMA $schema;" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/02-schema.sql" >/dev/null
  "${psql_base[@]}" -f - < "$clinic/03-seed.sql" >/dev/null
  if "${psql_base[@]}" --csv -f - < "$clinic/07-broken-model-or-query.sql" > "$actual_file"; then
    if diff -q "$clinic/06-expected-output.csv" "$actual_file" >/dev/null; then
      echo "FAIL broken model/query unexpectedly matched expected output: $clinic" >&2; exit 1
    fi
  else
    echo "FAIL broken model/query should execute and return wrong rows: $clinic" >&2; exit 1
  fi
  echo "PASS broken model/query did not match expected output"
}
echo "Testing base verification for $clinic"
run_case 03-seed.sql 06-expected-output.csv "$tmpdir/base.csv"
echo "Testing variant verification for $clinic"
run_case 03b-seed-variant.sql 06b-expected-output-variant.csv "$tmpdir/variant.csv"
run_broken
echo "PASS BANK R2 clinic proof: $clinic"
