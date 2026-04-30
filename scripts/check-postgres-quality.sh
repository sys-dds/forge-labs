#!/usr/bin/env bash
set -euo pipefail
chapter_required=(README.md 00-concept.explainer.md 00-dataset.story.md 01-schema.sql 02-seed.sql 03-demo.sql 04-solution.sql 05-proof.tests.sql 90-common-mistakes.sql 91-common-mistakes.explainer.md 98-extension-tasks.md)
practice_required=(README.md practice.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-starting-point.sql 04-solution.sql 05-proof.tests.sql 06-expected-results.md 07-break-fix-drills.md 08-interview-explanation.md)
gauntlet_required=(README.md gauntlet.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-broken-query.sql 04-solution.sql 05-proof.tests.sql 06-debugging-notes.md 07-break-fix-drills.md 08-interview-explanation.md)
drill_required=(prompt.md model-answer.md bad-answer.md follow-up-questions.md scorecard.md)
self_required=(README.md postgres-skill-rubric.md checklist.md weak-spot-map.md next-study-decision-tree.md postgres-to-optimisation-readiness.md)
banned=("Row group" "concrete case for a positive query result rather than abstract prose" "concrete case for an exclusion or edge condition rather than abstract prose" "The mistake 1:" "Why it feels reasonable 1:" "The production bug it creates 1:" "How the correct solution avoids it 1:" "This feature is useful in real backends" "PostgreSQL is powerful" "This chapter teaches an important concept")
fail(){ echo "FAIL $*" >&2; exit 1; }
[[ -f 02-postgres/README.md ]] || fail "missing 02-postgres/README.md"
[[ -f docs/postgres-learning-path.md ]] || fail "missing docs/postgres-learning-path.md"
for phrase in "${banned[@]}"; do
  if grep -R -F -- "$phrase" 02-postgres docs/postgres-*.md >/dev/null 2>&1; then
    fail "banned generated phrase found: $phrase"
  fi
done
chapter_count=0
for chapter in 02-postgres/[0-9][0-9]-*/; do
  [[ -d "$chapter" ]] || continue
  chapter_count=$((chapter_count+1))
  for file in "${chapter_required[@]}"; do [[ -f "$chapter/$file" ]] || fail "$chapter missing $file"; done
  for sql in 01-schema.sql 02-seed.sql 03-demo.sql 04-solution.sql 05-proof.tests.sql; do
    words=$(wc -w < "$chapter/$sql" | tr -d ' ')
    [[ "$words" -ge 5 ]] || fail "$chapter/$sql looks placeholder-only"
  done
  grep -F "## Proof Assertions" "$chapter/00-dataset.story.md" >/dev/null || fail "$chapter dataset story missing proof assertions"
done
[[ "$chapter_count" -eq 20 ]] || fail "expected 20 PostgreSQL chapters, found $chapter_count"
for pack in 02-postgres/_practice/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  for file in "${practice_required[@]}"; do [[ -f "$pack/$file" ]] || fail "$pack missing $file"; done
  grep -E '^id=.+' "$pack/practice.manifest" >/dev/null || fail "$pack manifest missing id"
  grep -E '^proof_file=05-proof.tests.sql' "$pack/practice.manifest" >/dev/null || fail "$pack manifest proof_file wrong"
done
for pack in 02-postgres/_gauntlet/[0-9][0-9]-*/; do
  [[ -d "$pack" ]] || continue
  for file in "${gauntlet_required[@]}"; do [[ -f "$pack/$file" ]] || fail "$pack missing $file"; done
  grep -E '^broken_query_file=03-broken-query.sql' "$pack/gauntlet.manifest" >/dev/null || fail "$pack manifest broken_query_file wrong"
done
for drill in 02-postgres/_interview-drills/[0-9][0-9]-*/; do
  [[ -d "$drill" ]] || continue
  for file in "${drill_required[@]}"; do [[ -f "$drill/$file" ]] || fail "$drill missing $file"; done
  cmp -s "$drill/model-answer.md" "$drill/bad-answer.md" && fail "$drill model and bad answer identical"
  grep -F "Senior signal:" "$drill/scorecard.md" >/dev/null || fail "$drill missing senior signal"
  grep -F "Red flag:" "$drill/scorecard.md" >/dev/null || fail "$drill missing red flag"
done
for file in "${self_required[@]}"; do [[ -f "02-postgres/_self-assessment/$file" ]] || fail "self-assessment missing $file"; done
printf 'PASS PostgreSQL quality gate
'
