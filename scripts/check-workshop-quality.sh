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
printf 'PASS workshop quality gate
'
