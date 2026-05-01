#!/usr/bin/env bash
set -euo pipefail

root="04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns"
parent="04-backend-interview-patterns-redone/README.md"

fail(){ echo "FAIL BIP PIM packaging: $*" >&2; exit 1; }

[[ -d "$root" ]] || fail "missing $root"
[[ -s "$parent" ]] || fail "missing parent README"

for n in $(seq -f "%03g" 1 40); do
  if ! find "$root" -maxdepth 1 -type d -name "$n-*" | grep -q .; then
    fail "missing clinic $n"
  fi
done

if find "$root" -maxdepth 1 -type d -name '041-*' | grep -q .; then
  fail "unexpected clinic beyond 040"
fi

docs=(
  PRODUCT_INTERACTION_PATTERN_MAP.md
  PIM_STUDY_PLAN.md
  PIM_CHEATSHEET.md
  PIM_INTERVIEW_ANSWERS.md
  PIM_COMMON_MODELING_MISTAKES.md
  PIM_CAPSTONE_GUIDE.md
  PIM_PRACTICE_ROUTES.md
)

for doc in "${docs[@]}"; do
  [[ -s "$root/$doc" ]] || fail "missing or empty $root/$doc"
done

for token in 001 010 020 025 030 035 040; do
  grep -q "$token" "$root/PRODUCT_INTERACTION_PATTERN_MAP.md" || fail "pattern map missing $token"
done

for token in 010 015 020 025 030 035 040; do
  grep -q "$token" "$root/PIM_CAPSTONE_GUIDE.md" || fail "capstone guide missing $token"
done

for token in Social Safety Marketplace Messaging Communities Discovery; do
  grep -qi "$token" "$root/PIM_PRACTICE_ROUTES.md" || fail "practice routes missing $token"
done

grep -Eiq "follow.*friendship|friendship.*follow" "$root/PIM_INTERVIEW_ANSWERS.md" || fail "interview answers missing follow vs friendship"
grep -Eiq "read receipts|read_receipts" "$root/PIM_INTERVIEW_ANSWERS.md" || fail "interview answers missing read receipts"
grep -Eiq "trust.*components|components.*trust" "$root/PIM_INTERVIEW_ANSWERS.md" || fail "interview answers missing trust components"
grep -Eiq "marketplace" "$root/PIM_INTERVIEW_ANSWERS.md" || fail "interview answers missing marketplace"
grep -Eiq "search|trending" "$root/PIM_INTERVIEW_ANSWERS.md" || fail "interview answers missing search/trending"

grep -Eiq "opaque trust score" "$root/PIM_COMMON_MODELING_MISTAKES.md" || fail "mistake catalog missing opaque trust score"
grep -Eiq "global unread count" "$root/PIM_COMMON_MODELING_MISTAKES.md" || fail "mistake catalog missing global unread count"
grep -Eiq "report count.*decision|decision.*report count" "$root/PIM_COMMON_MODELING_MISTAKES.md" || fail "mistake catalog missing report-count decision"
grep -Eiq "popularity-only|popularity only" "$root/PIM_COMMON_MODELING_MISTAKES.md" || fail "mistake catalog missing popularity-only ranking"

for doc in "${docs[@]}"; do
  grep -q "$doc" "$root/README.md" || fail "README missing link to $doc"
done

grep -Eiq "SQL Interview Patterns.*complete.*30|SQL.*complete.*30" "$parent" || fail "parent README missing SQL complete at 30"
grep -Eiq "Product Interaction.*complete.*40|PIM.*complete.*40" "$parent" || fail "parent README missing PIM complete at 40"
grep -Eiq "packaging|study layer" "$parent" || fail "parent README missing packaging/study layer"

if rg -n "TODO|lorem ipsum" "$root/PRODUCT_INTERACTION_PATTERN_MAP.md" "$root/PIM_STUDY_PLAN.md" "$root/PIM_CHEATSHEET.md" "$root/PIM_INTERVIEW_ANSWERS.md" "$root/PIM_COMMON_MODELING_MISTAKES.md" "$root/PIM_CAPSTONE_GUIDE.md" "$root/PIM_PRACTICE_ROUTES.md" "$root/README.md" "$root/00-how-to-study.md" "$parent"; then
  fail "placeholder text found"
fi

if rg -n "Spring|JPA|Redis|Kafka|OpenSearch|notebook|\\.ipynb" "$root/PRODUCT_INTERACTION_PATTERN_MAP.md" "$root/PIM_STUDY_PLAN.md" "$root/PIM_CHEATSHEET.md" "$root/PIM_INTERVIEW_ANSWERS.md" "$root/PIM_COMMON_MODELING_MISTAKES.md" "$root/PIM_CAPSTONE_GUIDE.md" "$root/PIM_PRACTICE_ROUTES.md" "$root/README.md" "$root/00-how-to-study.md" "$parent"; then
  fail "out-of-scope technology mention found in packaging docs"
fi

echo "PASS BIP PIM packaging"
