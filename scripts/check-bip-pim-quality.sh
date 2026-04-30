#!/usr/bin/env bash
set -euo pipefail
root="04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns"
fail(){ echo "FAIL BIP PIM quality: $*" >&2; exit 1; }
[[ -f "04-backend-interview-patterns-redone/README.md" ]] || fail "missing track README"
for f in README.md 00-how-to-study.md 00-product-interaction-pattern-map.md 00-common-data-modeling-traps.md 00-objects-relationships-events-read-models.md 00-feed-notification-activity-patterns.md 00-recommendation-candidate-basics.md 00-read-models-and-counters.md 00-visibility-and-user-controls.md; do [[ -s "$root/$f" ]] || fail "missing $root/$f"; done
[[ -f infra/docker-compose/docker-compose.postgres.yml ]] || fail "missing Docker/Postgres compose"
for s in bip-pim-list.sh bip-pim-test-one.sh bip-pim-test-all.sh check-bip-pim-quality.sh; do [[ -x "scripts/$s" ]] || fail "missing executable scripts/$s"; done
required=(README.md 00-interview-question.md 01-data-model.md 02-schema.sql 03-seed.sql 03b-seed-variant.sql 04-core-queries.sql 05-verification-query.sql 06-expected-output.csv 06b-expected-output-variant.csv 07-broken-model-or-query.sql 08-proof.sh 09-api-shape.md 10-read-write-path.md 11-scaling-notes.md 12-common-mistakes.md 13-how-to-explain-in-interview.md 14-shortcut-audit.md)
count=0
for clinic in "$root"/[0-9][0-9][0-9]-*; do
  [[ -d "$clinic" ]] || continue; count=$((count+1))
  for f in "${required[@]}"; do [[ -s "$clinic/$f" ]] || fail "missing or empty $clinic/$f"; done
  [[ -x "$clinic/08-proof.sh" ]] || fail "$clinic/08-proof.sh not executable"
  [[ "$(head -n 1 "$clinic/06-expected-output.csv")" == *,* ]] || fail "$clinic expected CSV missing header"
  [[ "$(wc -l < "$clinic/06-expected-output.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic expected CSV empty"
  [[ "$(wc -l < "$clinic/06b-expected-output-variant.csv" | tr -d ' ')" -gt 1 ]] || fail "$clinic variant expected CSV empty"
  if cmp -s "$clinic/05-verification-query.sql" "$clinic/07-broken-model-or-query.sql"; then fail "$clinic broken query identical to verification"; fi
  if grep -Eiq "where[[:space:][:alnum:]_\.]*_id[[:space:]]+in[[:space:]]*\(|order[[:space:]]+by[[:space:]]+case[[:space:]][[:alnum:]_\.]*_id|expected_output|expected-output|create[[:space:]]+(temporary[[:space:]]+|temp[[:space:]]+)?table[[:space:]]+(answer|expected|result)|from[[:space:]]+(answer|expected|result)" "$clinic/05-verification-query.sql"; then fail "$clinic verification contains shortcut pattern"; fi
  if grep -Eiq "select[[:space:]]+'[^']+'[[:space:]]+as[[:space:]]+contract_name[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]+as[[:space:]]+subject_id[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then fail "$clinic verification emits literal answer rows"; fi
  if grep -Eiq "values[[:space:]]*\\([[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'|union[[:space:]]+all[[:space:]]+select[[:space:]]+'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'[[:space:]]*,[[:space:]]*'[^']+'" "$clinic/05-verification-query.sql"; then fail "$clinic verification builds final answer from literal rows"; fi
  grep -qi "Actual tables" "$clinic/01-data-model.md" || fail "$clinic data model missing actual tables"
  grep -qi "Trap rows" "$clinic/01-data-model.md" || fail "$clinic data model missing trap rows"
  grep -qi "Constraints" "$clinic/01-data-model.md" || fail "$clinic data model missing constraints"
  grep -qi "Write path" "$clinic/10-read-write-path.md" || fail "$clinic missing write path"
  grep -qi "Read path" "$clinic/10-read-write-path.md" || fail "$clinic missing read path"
  grep -qi "Direct answer" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic missing interview direct answer"
  clinic_name="$(basename "$clinic")"; clinic_num="${clinic_name%%-*}"
  if [[ "$((10#$clinic_num))" -ge 6 ]]; then
    grep -Eiq "users|profiles|follow_edges|block_edges|posts|comments|swipe_events|matches|notifications|activity_events|user_interests" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing actual table names"
    grep -Eiq "[0-9]{3,4}|Ada|Ben|Cy|Eli|Diya|Hana|Ivan|Omar|Noor|Lina" "$clinic/13-how-to-explain-in-interview.md" || fail "$clinic interview explanation missing actual trap rows"
  fi
  grep -qi "variant proof catches" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing variant proof"
  grep -qi "mutation should fail" "$clinic/14-shortcut-audit.md" || fail "$clinic shortcut audit missing mutation"
  if grep -Riq "this clinic teaches product modeling\|TODO\|lorem ipsum" "$clinic"; then fail "$clinic contains placeholder wording"; fi
done
[[ "$count" -eq 15 ]] || fail "expected 15 clinics, found $count"
if find "$root" -maxdepth 1 -type d -name '016-*' | grep -q .; then fail "unexpected clinics beyond 015"; fi
for n in 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015; do
  ./scripts/bip-pim-list.sh | grep -q "/$n-" || fail "all-test list must include $n"
done
[[ "$(./scripts/bip-pim-list.sh | wc -l | tr -d ' ')" -eq 15 ]] || fail "all-test list must include exactly 001-015"
if rg -n "Spring|JPA|Redis|Kafka|sklearn|numpy|pandas|notebook|\.ipynb" "$root" scripts/bip-pim-*.sh; then fail "out-of-scope addition found"; fi
echo "PASS BIP PIM quality gate"
