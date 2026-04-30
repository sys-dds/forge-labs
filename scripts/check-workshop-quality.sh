#!/usr/bin/env bash
set -euo pipefail
required=(README.md 00-concept.explainer.md 00-dataset.story.md 90-common-mistakes.sql 91-common-mistakes.explainer.md 98-extension-tasks.md 99-chapter-proof.tests.sql)
banned=(
  "This chapter uses a realistic backend pattern so SQL is tied to product behavior rather than isolated syntax."
  "It builds on the earlier ideas of tables, relationships, constraints, and shaped queries."
  "Read/change task: change one selected output column in a solution query and rerun the chapter proof."
  "Add-a-query task: add one nearby query that answers a real backend question."
  "Add-a-constraint task: add or tighten one relevant database rule where the schema owns correctness."
  "Break/fix task: deliberately remove one important predicate or constraint, confirm the proof fails, then restore it."
  "Wrong pattern 1: relying on SELECT * instead of returning a shaped backend result."
  "Wrong pattern 2: forgetting the visibility or exclusion predicate that protects the viewer."
  "Wrong pattern 3: joining tables in a way that duplicates rows and inflates counts."
  "Wrong pattern 4: leaving correctness to application code when a database rule is available."
  "Think in three layers: the fact stored in a row"
  "I would model the durable facts first"
  "This looks tempting when you focus on the immediate query or endpoint"
  "It breaks real backend behavior because the database no longer protects"
  "The chapter solution avoids it by making the rule explicit"
  "Row group"
  "concrete case for a positive query result rather than abstract prose"
  "concrete case for an exclusion or edge condition rather than abstract prose"
  "The mistake 1:"
  "Why it feels reasonable 1:"
  "The production bug it creates 1:"
  "How the correct solution avoids it 1:"
)
word_count() { wc -w < "$1" | tr -d ' '; }
check_min_words() {
  local file="$1" min="$2" count
  count=$(word_count "$file")
  if [[ "$count" -lt "$min" ]]; then
    echo "FAIL $file has $count words, expected at least $min" >&2
    exit 1
  fi
}
check_dataset_sections() {
  local file="$1"
  local sections=("Scenario" "Named Dataset Rows" "Why Each Important Row Exists" "Positive Cases" "Negative/Exclusion Cases" "Proof Assertions" "Deliberate Break/Fix")
  for section in "${sections[@]}"; do
    if ! grep -F "## $section" "$file" >/dev/null; then
      echo "FAIL $file missing dataset story section: $section" >&2
      exit 1
    fi
  done
}
check_repeated_mistake_paragraphs() {
  local file="$1"
  local duplicates
  duplicates=$(grep -v '^#' "$file" | grep -v '^[[:space:]]*$' | sort | uniq -d || true)
  if [[ -n "$duplicates" ]]; then
    echo "FAIL $file repeats mistake paragraphs:" >&2
    echo "$duplicates" >&2
    exit 1
  fi
}
for chapter in 01-sql/[0-9][0-9]-*/; do
  chapter="${chapter%/}"
  for file in "${required[@]}"; do
    [[ -f "$chapter/$file" ]] || { echo "FAIL $chapter missing $file" >&2; exit 1; }
  done
  solution_count=$(find "$chapter" -maxdepth 1 -type f -name '*.solution.sql' | wc -l | tr -d ' ')
  if [[ "$solution_count" -lt 3 ]]; then
    echo "FAIL $chapter has fewer than 3 solution files" >&2
    exit 1
  fi
  for phrase in "${banned[@]}"; do
    if grep -R -F -- "$phrase" "$chapter" >/dev/null; then
      echo "FAIL banned generic phrase in $chapter: $phrase" >&2
      exit 1
    fi
  done
  check_min_words "$chapter/README.md" 350
  check_min_words "$chapter/00-concept.explainer.md" 450
  check_min_words "$chapter/00-dataset.story.md" 300
  check_dataset_sections "$chapter/00-dataset.story.md"
  check_repeated_mistake_paragraphs "$chapter/91-common-mistakes.explainer.md"
done

practice_required=(README.md challenge.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-starting-point.sql 04-solution.sql 05-proof.tests.sql 06-expected-results.md 07-break-fix-drills.md 08-interview-explanation.md)
manifest_required=(id title source_chapter difficulty concepts proof_file solution_file)
gauntlet_required=(README.md gauntlet.manifest 00-scenario.md 01-schema.sql 02-seed.sql 03-broken-query.sql 04-solution.sql 05-proof.tests.sql 06-debugging-notes.md 07-break-fix-drills.md 08-interview-explanation.md)
gauntlet_manifest_required=(id title source_chapter difficulty concepts dataset_entities bug_type broken_query_file solution_file proof_file expected_failure expected_fix estimated_time what_to_break_next)
takehome_required=(README.md 00-brief.md 01-schema.sql 02-seed.sql 03-candidate-task.md 04-solution.sql 05-proof.tests.sql 06-review-rubric.md 07-follow-up-questions.md 08-model-walkthrough.md)
drill_required=(prompt.md model-answer.md bad-answer.md follow-up-questions.md scorecard.md)
self_assessment_required=(README.md sql-skill-rubric.md checklist.md weak-spot-map.md next-study-decision-tree.md sql-to-postgres-readiness.md)

for pack in 01-sql/_practice/[0-9][0-9]-*/; do
  pack="${pack%/}"
  [[ -d "$pack" ]] || continue
  for file in "${practice_required[@]}"; do
    [[ -f "$pack/$file" ]] || { echo "FAIL $pack missing $file" >&2; exit 1; }
  done
  for key in "${manifest_required[@]}"; do
    if ! grep -E "^${key}=.+" "$pack/challenge.manifest" >/dev/null; then
      echo "FAIL $pack/challenge.manifest missing required key: $key" >&2
      exit 1
    fi
  done
  proof_file=$(awk -F= '$1=="proof_file"{print $2}' "$pack/challenge.manifest")
  solution_file=$(awk -F= '$1=="solution_file"{print $2}' "$pack/challenge.manifest")
  [[ "$proof_file" == "05-proof.tests.sql" ]] || { echo "FAIL $pack manifest proof_file should be 05-proof.tests.sql" >&2; exit 1; }
  [[ "$solution_file" == "04-solution.sql" ]] || { echo "FAIL $pack manifest solution_file should be 04-solution.sql" >&2; exit 1; }
done

for pack in 01-sql/_gauntlet/[0-9][0-9]-*/; do
  pack="${pack%/}"
  [[ -d "$pack" ]] || continue
  for file in "${gauntlet_required[@]}"; do
    [[ -f "$pack/$file" ]] || { echo "FAIL $pack missing $file" >&2; exit 1; }
  done
  for key in "${gauntlet_manifest_required[@]}"; do
    grep -E "^${key}=.+" "$pack/gauntlet.manifest" >/dev/null || { echo "FAIL $pack/gauntlet.manifest missing required key: $key" >&2; exit 1; }
  done
done

for pack in 01-sql/_takehomes/[0-9][0-9]-*/; do
  pack="${pack%/}"
  [[ -d "$pack" ]] || continue
  for file in "${takehome_required[@]}"; do
    [[ -f "$pack/$file" ]] || { echo "FAIL $pack missing $file" >&2; exit 1; }
  done
done

for drill in 01-sql/_interview-drills/[0-9][0-9]-*/; do
  drill="${drill%/}"
  [[ -d "$drill" ]] || continue
  for file in "${drill_required[@]}"; do
    [[ -f "$drill/$file" ]] || { echo "FAIL $drill missing $file" >&2; exit 1; }
  done
  if cmp -s "$drill/model-answer.md" "$drill/bad-answer.md"; then
    echo "FAIL $drill model answer and bad answer are identical" >&2
    exit 1
  fi
  grep -F "Senior signal:" "$drill/scorecard.md" >/dev/null || { echo "FAIL $drill scorecard missing senior signal" >&2; exit 1; }
  grep -F "Red flag:" "$drill/scorecard.md" >/dev/null || { echo "FAIL $drill scorecard missing red flag" >&2; exit 1; }
done

for file in "${self_assessment_required[@]}"; do
  [[ -f "01-sql/_self-assessment/$file" ]] || { echo "FAIL 01-sql/_self-assessment missing $file" >&2; exit 1; }
done
printf 'PASS workshop quality gate
'
