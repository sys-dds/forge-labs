#!/usr/bin/env bash
set -euo pipefail
root="05-banking-systems-redone"
fail(){ echo "FAIL BANK R2 quality: $*" >&2; exit 1; }
[[ -s "$root/README.md" ]] || fail "missing root README"
for f in 00-how-to-study.md 00-banking-correctness-map.md 00-ledger-mental-model.md 00-common-banking-modeling-traps.md; do [[ -s "$root/$f" ]] || fail "missing $root/$f"; done
[[ -f infra/docker-compose/docker-compose.postgres.yml ]] || fail "missing Docker/Postgres compose"
for s in bank-r2-list.sh bank-r2-test-one.sh bank-r2-test-all.sh check-bank-r2-quality.sh; do [[ -x "scripts/$s" ]] || fail "missing executable scripts/$s"; done
required=(README.md 00-interview-question.md 01-data-model.md 02-schema.sql 03-seed.sql 03b-seed-variant.sql 04-core-queries.sql 05-verification-query.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-broken-model-or-query.sql 08-proof.sh 09-api-shape.md 10-read-write-path.md 11-correctness-notes.md 12-common-mistakes.md 13-how-to-explain-in-interview.md 14-shortcut-audit.md)
count=0
for clinic in "$root"/[0-9][0-9][0-9]-*; do
  [[ -d "$clinic" ]] || continue; count=$((count+1))
  for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || fail "missing or empty $clinic/$f"; done
  [[ -x "$clinic/08-proof.sh" ]] || fail "$clinic/08-proof.sh not executable"
  [[ "$(head -n 1 "$clinic/06-expected-output.csv")" == "contract_name,subject_id,observed_value,expected_reason" ]] || fail "$clinic expected CSV missing contract header"
  [[ "$(wc -l < "$clinic/06-expected-output.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic expected CSV empty"
  [[ "$(wc -l < "$clinic/06b-expected-output-variant.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic variant expected CSV empty"
  cmp -s "$clinic/05-verification-query.sql" "$clinic/07-broken-model-or-query.sql" && fail "$clinic broken query identical to verification"
  if grep -Eiq "expected_output|expected-output|create[[:space:]]+(temporary[[:space:]]+|temp[[:space:]]+)?table[[:space:]]+(answer|expected|result)|from[[:space:]]+(answer|expected|result)" "$clinic/05-verification-query.sql"; then fail "$clinic verification contains shortcut pattern"; fi
  if grep -Eiq "values[[:space:]]*\\([[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'|union[[:space:]]+all[[:space:]]+select[[:space:]]+'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then fail "$clinic verification builds final answer from literal rows"; fi
  grep -qi "Actual tables" "$clinic/01-data-model.md" || fail "$clinic data model missing actual tables"
  grep -qi "Trap rows" "$clinic/01-data-model.md" || fail "$clinic data model missing trap rows"
  grep -qi "Constraints" "$clinic/01-data-model.md" || fail "$clinic data model missing constraints"
  grep -qi "Direct answer" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing direct answer"
  grep -qi "variant proof catches" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing variant proof"
  grep -qi "mutation should fail" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing mutation"
  grep -Eiq "accounts|ledger_entries|ledger_transactions|transfer_requests|idempotency_keys|transaction_events|account_holds|reversals" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing banking table names"
  grep -Eiq "[0-9]{3,5}|Ada|Ben|hold|transfer|ledger|reversal|idempotency" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing trap rows"
  [[ "$(grep -Eic '^-- query|^-- Query|select ' "$clinic/04-core-queries.sql")" -ge 3 ]] || fail "$clinic core queries need at least 3 examples"
  if grep -Riq "this clinic teaches banking\\|TODO\\|lorem ipsum" "$clinic"; then fail "$clinic contains placeholder wording"; fi
done
[[ "$count" -eq 5 ]] || fail "expected 5 clinics, found $count"
if find "$root" -maxdepth 1 -type d -name '006-*' | grep -q .; then fail "unexpected clinics beyond 005"; fi
for n in 001 002 003 004 005; do ./scripts/bank-r2-list.sh | grep -q "/$n-" || fail "all-test list must include $n"; done
[[ "$(./scripts/bank-r2-list.sh | wc -l | tr -d ' ')" -eq 5 ]] || fail "all-test list must include exactly 001-005"
grep -Rqi "ledger_entries" "$root" || fail "track lacks ledger/source-of-truth explanation"
grep -Rqi "idempotency_keys" "$root"/003-* "$root"/005-* || fail "transfer clinics lack idempotency model"
grep -Rqi "debit" "$root"/002-* "$root"/005-* || fail "ledger clinics lack debit proof"
grep -Rqi "credit" "$root"/002-* "$root"/005-* || fail "ledger clinics lack credit proof"
if rg -n "Spring|JPA|Redis|Kafka|notebook|\\.ipynb|OpenSearch|real-money|production banking" "$root" scripts/bank-r2-*.sh; then fail "out-of-scope addition found"; fi
echo "PASS BANK R2 quality gate"
