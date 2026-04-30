#!/usr/bin/env bash
set -euo pipefail

root="01-sql-redone"
clinics=(
  "01-modeling-constraints-relationships"
  "02-feed-candidates-and-joins"
  "03-aggregation-grain-and-row-multiplication"
  "04-keyset-pagination-stable-feeds"
  "05-matching-candidates-and-exclusions"
)
required=(
  README.md
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
  "concrete case for a positive query result"
  "concrete case for an exclusion or edge condition"
  "This breaks backend behavior"
  "This chapter teaches an important concept"
  "The production bug it creates 1"
  "Why it feels reasonable 1"
  "anchors a row"
  "real-world backend pattern"
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
  grep -qi "backend scenario" "$path/README.md" || fail "$path/README.md must name the backend scenario"
  named_count=$(grep -Eio '\b(Ada|Ben|Cy|Diya|Noor|Maya|Omar|A1|A2|A3|B1|post 10[1-8]|post 20[1]|post 30[1]|post 40[1])\b' "$path/06-debugging-notes.md" | sort -u | wc -l | tr -d ' ')
  [[ "$named_count" -ge 3 ]] || fail "$path/06-debugging-notes.md must mention at least 3 named rows"
  drill_count=$(grep -Ec '^([0-9]+\.|- )' "$path/07-break-fix-drills.md")
  [[ "$drill_count" -ge 4 ]] || fail "$path/07-break-fix-drills.md must have at least 4 drills"
  grep -qi "direct answer" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing direct answer"
  grep -qi "dataset walkthrough" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing dataset walkthrough"
  grep -qi "common mistake" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing common mistake"
  grep -qi "senior trade-off" "$path/08-interview-explanation.md" || fail "$path/08-interview-explanation.md missing senior trade-off"
done

for phrase in "${banned[@]}"; do
  if grep -RFn -- "$phrase" "$root" >/tmp/sql-redone-banned.txt; then
    cat /tmp/sql-redone-banned.txt >&2
    fail "banned fake-depth phrase appears: $phrase"
  fi
done

echo "PASS SQL redone quality gate"
