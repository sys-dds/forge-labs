#!/usr/bin/env bash
set -euo pipefail
root="04-backend-interview-patterns-redone/01-sql-interview-patterns"
fail(){ echo "FAIL BIP SQL quality: $*" >&2; exit 1; }
[[ -f "04-backend-interview-patterns-redone/README.md" ]] || fail "missing track README"
for f in README.md 00-how-to-study.md 00-sql-interview-pattern-map.md 00-common-sql-traps.md 00-window-functions-for-interviews.md 00-time-series-sql-patterns.md 00-investigation-query-patterns.md 00-senior-sql-correctness-patterns.md 00-sql-reconciliation-patterns.md 00-sql-debugging-and-investigation-patterns.md; do [[ -s "$root/$f" ]] || fail "missing $root/$f"; done
[[ -f infra/docker-compose/docker-compose.postgres.yml ]] || fail "missing Docker/Postgres compose"
for s in bip-sql-up.sh bip-sql-down.sh bip-sql-reset.sh bip-sql-list.sh bip-sql-test-one.sh bip-sql-test-all.sh check-bip-sql-quality.sh; do [[ -x "scripts/$s" ]] || fail "missing executable scripts/$s"; done
required=(README.md 00-pattern.md 01-schema.sql 02-seed.sql 02b-seed-variant.sql 03-question.md 04-broken-attempt.sql 05-solution.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-proof.sh 08-explain-in-interview.md 09-follow-up-variants.md 10-shortcut-audit.md)
count=0
for clinic in "$root"/[0-9][0-9][0-9]-*; do
  [[ -d "$clinic" ]] || continue; count=$((count+1))
  for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || fail "missing or empty $clinic/$f"; done
  [[ -x "$clinic/07-proof.sh" ]] || fail "$clinic/07-proof.sh not executable"
  [[ "$(head -n 1 "$clinic/06-expected-output.csv")" == *,* ]] || fail "$clinic expected CSV missing header"
  [[ "$(wc -l < "$clinic/06-expected-output.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic expected CSV empty"
  [[ "$(wc -l < "$clinic/06b-expected-output-variant.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic variant expected CSV empty"
  if grep -Eiq "where[[:space:][:alnum:]_\.]*_id[[:space:]]+in[[:space:]]*\(|order[[:space:]]+by[[:space:]]+case[[:space:]][[:alnum:]_\.]*_id|select[[:space:]]+'[^']+'[[:space:]]+as|expected_output|expected-output" "$clinic/05-solution.sql"; then fail "$clinic solution contains shortcut pattern"; fi
  if cmp -s "$clinic/04-broken-attempt.sql" "$clinic/05-solution.sql"; then fail "$clinic broken attempt identical to solution"; fi
  grep -qi "Actual tables" "$clinic/00-pattern.md" || fail "$clinic pattern missing actual tables"
  grep -qi "Actual rows" "$clinic/00-pattern.md" || fail "$clinic pattern missing actual rows"
  grep -qi "Why the broken query fails" "$clinic/00-pattern.md" || fail "$clinic pattern missing broken explanation"
  grep -qi "Direct answer" "$clinic/08-explain-in-interview.md" || fail "$clinic interview explanation missing direct answer"
  grep -qi "Dataset walkthrough" "$clinic/08-explain-in-interview.md" || fail "$clinic interview explanation missing dataset walkthrough"
  grep -qi "Query reasoning" "$clinic/08-explain-in-interview.md" || fail "$clinic interview explanation missing query reasoning"
  grep -qi "Common mistake" "$clinic/08-explain-in-interview.md" || fail "$clinic interview explanation missing common mistake"
  grep -qi "Follow-up answer" "$clinic/08-explain-in-interview.md" || fail "$clinic interview explanation missing follow-up answer"
  grep -qi "variant dataset catches" "$clinic/10-shortcut-audit.md" || fail "$clinic shortcut audit missing variant catch"
  if grep -Riq "this clinic teaches SQL pattern\|TODO\|lorem ipsum" "$clinic"; then fail "$clinic contains placeholder wording"; fi
done
[[ "$count" -eq 30 ]] || fail "expected 30 clinics, found $count"
if find "$root" -maxdepth 1 -type d -name '031-*' | grep -q .; then fail "unexpected clinics beyond 030"; fi
[[ "$(./scripts/bip-sql-list.sh | wc -l | tr -d ' ')" -eq 30 ]] || fail "all-test list must include 001-030"
if rg -n "Spring|JPA|frontend|Redis|Kafka|sklearn|numpy|pandas|notebook|\.ipynb" 04-backend-interview-patterns-redone scripts/bip-sql-*.sh; then fail "out-of-scope addition found"; fi
echo "PASS BIP SQL quality gate"
