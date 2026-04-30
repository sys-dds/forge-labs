#!/usr/bin/env bash
set -euo pipefail

root="01-sql-redone"
clinics=(
  "01-modeling-constraints-relationships"
  "02-feed-candidates-and-joins"
  "03-aggregation-grain-and-row-multiplication"
  "04-keyset-pagination-stable-feeds"
  "05-matching-candidates-and-exclusions"
  "06-public-profile-projection-and-privacy"
  "07-social-graph-suggestions-and-mutuals"
  "08-recursive-comment-threads"
  "09-analytics-funnel-and-daily-metrics"
  "10-sql-endpoint-capstone"
)
required=(
  README.md
  00-design.md
  00-scenario.md
  01-schema.sql
  02-seed.sql
  03-broken-query.sql
  04-solution.sql
  05-proof.tests.sql
  06-debugging-notes.md
  07-break-fix-drills.md
  08-interview-explanation.md
  09-what-to-notice.md
)
banned=(
  "Row group"
  "Teaching row"
  "anchors a row"
  "concrete case for a positive query result"
  "concrete case for an exclusion or edge condition"
  "This breaks backend behavior"
  "This chapter teaches an important concept"
  "real-world backend pattern"
  "positive backend path"
  "negative row proves"
  "generic projection"
  "app-only rule"
  "weak proof"
  "interview repair"
)
design_sections=(
  "What this clinic teaches"
  "Named rows"
  "Broken query bug"
  "Exact wrong result"
  "Correct result"
  "Proof assertions"
  "What the learner should notice"
  "Interview explanation target"
)

fail() {
  echo "FAIL $*" >&2
  exit 1
}

[[ -f "$root/README.md" ]] || fail "missing $root/README.md"
[[ -f "$root/00-how-to-study.md" ]] || fail "missing $root/00-how-to-study.md"
[[ -f "$root/00-clinic-format.md" ]] || fail "missing $root/00-clinic-format.md"

for clinic in "${clinics[@]}"; do
  path="$root/$clinic"
  [[ -d "$path" ]] || fail "missing clinic $path"
  for file in "${required[@]}"; do
    [[ -f "$path/$file" ]] || fail "missing $path/$file"
  done
  for file in 01-schema.sql 02-seed.sql 03-broken-query.sql 04-solution.sql 05-proof.tests.sql; do
    [[ -s "$path/$file" ]] || fail "$path/$file must be non-empty"
  done
  for section in "${design_sections[@]}"; do
    grep -qi "$section" "$path/00-design.md" || fail "$path/00-design.md missing $section"
  done
  grep -qi "backend scenario" "$path/README.md" || fail "$path/README.md must name the backend scenario"
  named_count=$(grep -Eio '\b(Ada|Ben|Cy|Diya|Noor|Maya|Omar|Theo|Lina|A1|A2|A3|B1|c[1-8]|post [0-9]+|[0-9]{3}|2026-01-0[12])\b' "$path/06-debugging-notes.md" | sort -u | wc -l | tr -d ' ')
  if [[ "$clinic" =~ ^0[6-9]-|^10- ]]; then
    [[ "$named_count" -ge 4 ]] || fail "$path/06-debugging-notes.md must mention at least 4 named rows"
  else
    [[ "$named_count" -ge 3 ]] || fail "$path/06-debugging-notes.md must mention at least 3 named rows"
  fi
  drill_count=$(grep -Ec '^([0-9]+\.|- )' "$path/07-break-fix-drills.md")
  [[ "$drill_count" -ge 4 ]] || fail "$path/07-break-fix-drills.md must have at least 4 drills"
  grep -qi "direct answer" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing direct answer"
  grep -qi "dataset walkthrough" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing dataset walkthrough"
  grep -qi "query reasoning" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing query reasoning"
  grep -qi "common mistake" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing common mistake"
  grep -qi "senior trade-off" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing senior trade-off"
  grep -qi "follow-up answer" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing follow-up answer"
done

for phrase in "${banned[@]}"; do
  if grep -RFn -- "$phrase" "$root" >/tmp/sql-redone-banned.txt; then
    cat /tmp/sql-redone-banned.txt >&2
    fail "banned fake-depth phrase appears: $phrase"
  fi
done

echo "PASS SQL redone quality gate"
