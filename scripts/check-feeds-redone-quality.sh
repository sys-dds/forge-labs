#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail() {
  echo "FAIL feeds redone quality: $*" >&2
  exit 1
}

root_files=(
  03-feeds-ranking-redone/README.md
  03-feeds-ranking-redone/00-feed-systems-map.md
  03-feeds-ranking-redone/00-how-to-study.md
  03-feeds-ranking-redone/00-clinic-format.md
  03-feeds-ranking-redone/00-roadmap.md
  03-feeds-ranking-redone/00-beginner-vocabulary.md
  03-feeds-ranking-redone/00-ranking-maths-for-beginners.md
  03-feeds-ranking-redone/00-debugging-feed-output.md
  03-feeds-ranking-redone/00-feed-evaluation-for-beginners.md
  03-feeds-ranking-redone/00-retrieval-for-beginners.md
)

shared_files=(
  03-feeds-ranking-redone/_shared/import_simulation.py
  03-feeds-ranking-redone/_shared/assertions.py
  03-feeds-ranking-redone/_shared/result_contract.py
  03-feeds-ranking-redone/_shared/scoring_math.py
  03-feeds-ranking-redone/_shared/trace_helpers.py
  03-feeds-ranking-redone/_shared/retrieval_math.py
)

clinics=(
  03-feeds-ranking-redone/01-feed-pipeline-mental-model
  03-feeds-ranking-redone/02-social-graph-candidate-generation
  03-feeds-ranking-redone/03-out-of-network-recommendations
  03-feeds-ranking-redone/04-candidate-mixing-deduplication
  03-feeds-ranking-redone/05-ranking-signals-feature-rows
  03-feeds-ranking-redone/06-scoring-models-multi-objective-ranking
  03-feeds-ranking-redone/07-diversity-exploration-mixing
  03-feeds-ranking-redone/08-stories-ephemeral-content-snapchat-patterns
  03-feeds-ranking-redone/09-recommended-notifications
  03-feeds-ranking-redone/10-feed-evaluation-debugging-simulation
  03-feeds-ranking-redone/11-following-feed-vs-for-you-feed
  03-feeds-ranking-redone/12-short-video-ranking-patterns
  03-feeds-ranking-redone/13-youtube-style-home-and-up-next
  03-feeds-ranking-redone/14-hot-ranking-reddit-hacker-news-patterns
  03-feeds-ranking-redone/15-linkedin-professional-feed-ranking
  03-feeds-ranking-redone/16-marketplace-recommendation-ranking
  03-feeds-ranking-redone/17-search-ranking-vs-feed-ranking
  03-feeds-ranking-redone/18-creator-discovery-and-cold-start
  03-feeds-ranking-redone/19-safety-integrity-ranking
  03-feeds-ranking-redone/20-beginner-ranking-maths-and-score-debugging
  03-feeds-ranking-redone/21-offline-replay-and-golden-feed-regression
  03-feeds-ranking-redone/22-why-did-i-see-this-explanation-traces
  03-feeds-ranking-redone/23-why-did-i-not-see-this-missing-item-debugger
  03-feeds-ranking-redone/24-feedback-loops-and-echo-chamber-simulator
  03-feeds-ranking-redone/25-ranking-metrics-for-beginners
  03-feeds-ranking-redone/26-ab-testing-and-experiment-guardrails
  03-feeds-ranking-redone/27-pre-ranking-reranking-and-latency-budget
  03-feeds-ranking-redone/28-freshness-stale-candidates-and-already-seen-filtering
  03-feeds-ranking-redone/29-feed-incident-clinic
  03-feeds-ranking-redone/30-senior-feed-system-design-capstone
  03-feeds-ranking-redone/31-retrieval-funnel-mental-model
  03-feeds-ranking-redone/32-lexical-vs-semantic-retrieval
  03-feeds-ranking-redone/33-embeddings-for-beginners
  03-feeds-ranking-redone/34-two-tower-retrieval-mental-model
  03-feeds-ranking-redone/35-approximate-nearest-neighbour-mental-model
  03-feeds-ranking-redone/36-hybrid-retrieval-and-source-blending
  03-feeds-ranking-redone/37-retrieval-recall-precision-evaluation
  03-feeds-ranking-redone/38-cold-start-retrieval-and-exploration-backfill
  03-feeds-ranking-redone/39-retrieval-debugging-why-candidate-was-missing
  03-feeds-ranking-redone/40-senior-retrieval-system-design-capstone
)

for file in "${root_files[@]}" "${shared_files[@]}"; do
  [[ -s "$file" ]] || fail "missing required file $file"
done

for clinic in "${clinics[@]}"; do
  [[ -d "$clinic" ]] || fail "missing clinic $clinic"
  common=(README.md 00-design.md 00-scenario.md 01-dataset.json 02-broken_simulation.py 03-solution.py 04-proof.tests.py 05-debugging-notes.md 06-break-fix-drills.md 07-interview-explanation.md 08-what-to-notice.md 09-evidence-map.md)
  for file in "${common[@]}"; do [[ -s "$clinic/$file" ]] || fail "missing $clinic/$file"; done
  clinic_name="$(basename "$clinic")"
  if [[ "$clinic_name" =~ ^(31|32|33|34|35|36|37|38|39|40)- ]]; then
    extra=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
  elif [[ "$clinic_name" =~ ^(21|22|23|24|25|26|27|28|29|30)- ]]; then
    extra=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
  elif [[ "$clinic_name" =~ ^(11|12|13|14|15|16|17|18|19|20)- ]]; then
    extra=(10-beginner-walkthrough.md 11-shortcut-audit.md 12-mutation-checks.md)
  else
    extra=(10-mutation-checks.md)
  fi
  for file in "${extra[@]}"; do [[ -s "$clinic/$file" ]] || fail "missing $clinic/$file"; done

  python3 -m json.tool "$clinic/01-dataset.json" >/dev/null || fail "invalid JSON $clinic/01-dataset.json"
  PYTHONPYCACHEPREFIX=/tmp/forge-feeds-redone-pycache python3 -m py_compile "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py" || fail "python compile failed in $clinic"

  grep -q '| Item | Exists because | Used by proof | Used by debug trace | Used by drill |' "$clinic/09-evidence-map.md" || fail "$clinic evidence map missing table"
  evidence_rows="$(grep -Ec '^\| [^|-]' "$clinic/09-evidence-map.md")"
  [[ "$evidence_rows" -ge 7 ]] || fail "$clinic evidence map needs at least 6 item rows"
  if grep -v '^| Item |' "$clinic/09-evidence-map.md" | grep -Eq '\| Used by proof \||\| Used by debug trace \||\| Used by drill \|'; then
    fail "$clinic evidence map has vague cells"
  fi

  if [[ "$clinic_name" =~ ^(31|32|33|34|35|36|37|38|39|40)- ]]; then
    for heading in "What this clinic teaches" "Retrieval problem and user intent" "Named users/items/sources and why each exists" "Broken retrieval behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
      if grep -Eq 'import +(numpy|pandas|sklearn|faiss|annoy|hnswlib)|from +(numpy|pandas|sklearn|faiss|annoy|hnswlib)' "$file"; then fail "$file imports non-scope retrieval dependency"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +expected\["retrieved_candidates"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'assert_equal\(result\.get\("(final_candidate_pool|retrieved_candidates|hybrid_candidates|ann_candidates|ada_candidates|winner_for_first_stage_retrieval)' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks exact retrieved output assertion"
    grep -Eq 'missed_candidates|missing_candidate_explanations|assert_rejected|missed_by_ann|false_negatives' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks retrieved/missed/rejected assertion"
    grep -q 'retrieval_debug_trace' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks retrieval_debug_trace assertion"
    if [[ "$clinic_name" =~ ^(33|34|35)- ]]; then
      grep -q 'similarity_rows' "$clinic/04-proof.tests.py" || fail "$clinic vector proof lacks similarity_rows assertion"
    fi
    if [[ "$clinic_name" =~ ^37- ]]; then
      grep -q 'recall_report' "$clinic/04-proof.tests.py" || fail "$clinic evaluation proof lacks recall_report assertion"
      grep -q 'precision_report' "$clinic/04-proof.tests.py" || fail "$clinic evaluation proof lacks precision_report assertion"
    fi
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(21|22|23|24|25|26|27|28|29|30)- ]]; then
    for heading in "What this clinic teaches" "Product surface and operating problem" "Named users/content/events and why each exists" "Broken operating/ranking behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'assert_equal\(result\.get\("(final_feed|actual_feed|golden_feed|winner|launch_decision|corrected_feed|following_feed|for_you_feed|stories_tray|search_results|notification_candidates|creator_discovery)' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks exact output assertion"
    grep -Eq 'assert_rejected|missing_explanations|regression_report|guardrail_failures|root_causes|not in|excluded' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks rejected/missing/regressed assertion"
    grep -q 'assert_debug_trace\|assert_trace_contains' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks debug trace assertion"
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(11|12|13|14|15|16|17|18|19|20)- ]]; then
    for heading in "Product surface and user intent" "Beginner mental model"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'assert_equal\(result\.get\("(final_feed|following_feed|for_you_feed|short_video_feed|home_recommendations|up_next|hot_ranked_posts|professional_feed|marketplace_recommendations|search_results|creator_discovery)' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks exact output assertion"
    grep -Eq 'assert_rejected|not in|excluded' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks rejection/exclusion assertion"
    grep -q 'assert_debug_trace\|assert_trace_contains' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks debug trace assertion"
    grep -q '| Mutation | Expected failing proof |' "$clinic/12-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/12-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
  fi
done

banned=(
  "Row group" "Teaching row" "anchors a row" "concrete case" "This breaks backend behavior"
  "This chapter teaches an important concept" "real-world backend pattern" "useful in real systems"
  "production systems need this" "ranking is important" "recommendations are important"
  "social apps use this" "this is a common pattern" "weak proof" "generic feed"
  "generic ranking" "generic candidate" "positive case" "negative case" "edge case" "realistic scenario"
  "is a named part of deciding what Ada sees and why" "treating <term> as hidden magic"
)
for phrase in "${banned[@]}"; do
  if grep -Riq "$phrase" 03-feeds-ranking-redone; then fail "banned fake-depth phrase found: $phrase"; fi
done

grep -q "0.9\*1.0" 03-feeds-ranking-redone/00-embedding-maths-for-beginners.md || fail "root docs define embeddings without numeric example"
grep -q "exact scan checks every row" 03-feeds-ranking-redone/00-retrieval-for-beginners.md || fail "root docs define ANN without approximate-vs-exact trade-off"
if grep -RIEq "import +(numpy|pandas|sklearn|faiss|annoy|hnswlib)|from +(numpy|pandas|sklearn|faiss|annoy|hnswlib)" 03-feeds-ranking-redone scripts; then fail "non-scope ML/vector dependency imported"; fi

echo "PASS feeds redone quality gate"
