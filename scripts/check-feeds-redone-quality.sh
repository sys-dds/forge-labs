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
  03-feeds-ranking-redone/00-social-graph-for-beginners.md
  03-feeds-ranking-redone/00-graph-algorithms-for-beginners.md
  03-feeds-ranking-redone/00-graph-debugging-playbook.md
  03-feeds-ranking-redone/00-community-recommendations-map.md
  03-feeds-ranking-redone/00-safety-integrity-for-beginners.md
  03-feeds-ranking-redone/00-policy-treatment-map.md
  03-feeds-ranking-redone/00-abuse-and-trust-debugging-playbook.md
  03-feeds-ranking-redone/00-safety-aware-ranking-map.md
  03-feeds-ranking-redone/00-creator-ecosystem-for-beginners.md
)

shared_files=(
  03-feeds-ranking-redone/_shared/import_simulation.py
  03-feeds-ranking-redone/_shared/assertions.py
  03-feeds-ranking-redone/_shared/result_contract.py
  03-feeds-ranking-redone/_shared/scoring_math.py
  03-feeds-ranking-redone/_shared/trace_helpers.py
  03-feeds-ranking-redone/_shared/retrieval_math.py
  03-feeds-ranking-redone/_shared/graph_helpers.py
  03-feeds-ranking-redone/_shared/safety_helpers.py
  03-feeds-ranking-redone/_shared/ecosystem_helpers.py
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
  03-feeds-ranking-redone/41-social-graph-data-model
  03-feeds-ranking-redone/42-mutual-friends-triangle-closing
  03-feeds-ranking-redone/43-bipartite-user-item-collaborative-filtering
  03-feeds-ranking-redone/44-random-walk-recommendation-intuition
  03-feeds-ranking-redone/45-pagerank-style-authority-propagation
  03-feeds-ranking-redone/46-community-detection-interest-clusters
  03-feeds-ranking-redone/47-heterogeneous-graph-recommendations
  03-feeds-ranking-redone/48-edge-freshness-decay-interaction-strength
  03-feeds-ranking-redone/49-graph-candidate-debugging-why-missing
  03-feeds-ranking-redone/50-senior-social-graph-recommendation-system-design-capstone
  03-feeds-ranking-redone/51-safety-policy-decision-taxonomy
  03-feeds-ranking-redone/52-hard-filters-downranking-labels
  03-feeds-ranking-redone/53-spam-clickbait-engagement-farming-suppression
  03-feeds-ranking-redone/54-fake-engagement-bot-rings-coordinated-abuse
  03-feeds-ranking-redone/55-trust-score-account-reputation-source-quality
  03-feeds-ranking-redone/56-reporter-reliability-review-queues
  03-feeds-ranking-redone/57-sensitive-borderline-content-context-treatment
  03-feeds-ranking-redone/58-appeals-reversals-audit-lineage
  03-feeds-ranking-redone/59-safety-incident-debugging-regression-checks
  03-feeds-ranking-redone/60-senior-safety-aware-feed-ranking-system-design-capstone
  03-feeds-ranking-redone/61-creator-exposure-budgets-popularity-bias-control
  03-feeds-ranking-redone/62-cold-start-creator-ranking-exploration-slots
  03-feeds-ranking-redone/63-long-tail-content-quality-audience-fit
  03-feeds-ranking-redone/64-creator-fatigue-diversity-repeated-author-caps
  03-feeds-ranking-redone/65-marketplace-buyer-intent-listing-relevance
  03-feeds-ranking-redone/66-seller-quality-trust-fulfilment-response-ranking
  03-feeds-ranking-redone/67-marketplace-supply-demand-local-availability
  03-feeds-ranking-redone/68-marketplace-risk-disputes-refunds-fraud-suppression
  03-feeds-ranking-redone/69-ecosystem-debugging-why-not-shown
  03-feeds-ranking-redone/70-senior-creator-marketplace-ranking-system-design-capstone
)

for file in "${root_files[@]}" "${shared_files[@]}"; do
  [[ -s "$file" ]] || fail "missing required file $file"
done

for clinic in "${clinics[@]}"; do
  [[ -d "$clinic" ]] || fail "missing clinic $clinic"
  common=(README.md 00-design.md 00-scenario.md 01-dataset.json 02-broken_simulation.py 03-solution.py 04-proof.tests.py 05-debugging-notes.md 06-break-fix-drills.md 07-interview-explanation.md 08-what-to-notice.md 09-evidence-map.md)
  for file in "${common[@]}"; do [[ -s "$clinic/$file" ]] || fail "missing $clinic/$file"; done
  clinic_name="$(basename "$clinic")"

  if [[ "$clinic_name" =~ ^(61|62|63|64|65|66|67|68|69|70)- ]]; then
    for heading in "What this clinic teaches" "Creator/marketplace problem and user impact" "Named viewers/buyers/creators/sellers/listings and why each exists" "Broken ecosystem/ranking behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
      if grep -Eq 'import +(numpy|pandas|sklearn)|from +(numpy|pandas|sklearn)' "$file"; then fail "$file imports non-scope marketplace dependency"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +expected\["marketplace_rankings"\]|return +expected\["creator_rankings"\]|return +expected\["seller_rankings"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'ecosystem_debug_trace|debug_trace' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks ecosystem_debug_trace or debug_trace assertion"
    grep -Eq 'assert_rejected|risk_suppressed_items|downranked_items|exposure_rows|fairness_rows' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks rejected/risk/downranked/exposure/fairness assertion"
    if [[ "$clinic_name" =~ ^61- ]]; then grep -q 'exposure_rows' "$clinic/04-proof.tests.py" || fail "$clinic exposure proof lacks exposure_rows assertion"; fi
    if [[ "$clinic_name" =~ ^62- ]]; then grep -q 'cold_start_rows' "$clinic/04-proof.tests.py" || fail "$clinic cold-start proof lacks cold_start_rows assertion"; fi
    if [[ "$clinic_name" =~ ^63- ]]; then grep -Eq 'long_tail_rows|popularity_bias_rows' "$clinic/04-proof.tests.py" || fail "$clinic long-tail proof lacks long_tail/popularity assertion"; fi
    if [[ "$clinic_name" =~ ^65- ]]; then grep -q 'buyer_intent_rows' "$clinic/04-proof.tests.py" || fail "$clinic buyer intent proof lacks buyer_intent_rows assertion"; fi
    if [[ "$clinic_name" =~ ^66- ]]; then grep -q 'seller_quality_rows' "$clinic/04-proof.tests.py" || fail "$clinic seller quality proof lacks seller_quality_rows assertion"; fi
    if [[ "$clinic_name" =~ ^67- ]]; then grep -q 'supply_rows' "$clinic/04-proof.tests.py" && grep -q 'demand_rows' "$clinic/04-proof.tests.py" || fail "$clinic supply demand proof lacks rows assertion"; fi
    if [[ "$clinic_name" =~ ^68- ]]; then grep -q 'trust_score_rows\|risk_score_rows' "$clinic/04-proof.tests.py" || fail "$clinic risk proof lacks trust/risk rows assertion"; fi
    if [[ "$clinic_name" =~ ^69- ]]; then grep -q 'missing_ecosystem_explanations' "$clinic/04-proof.tests.py" || fail "$clinic debugging proof lacks missing ecosystem explanation assertion"; fi
    if [[ "$clinic_name" =~ ^70- ]]; then grep -q 'ecosystem_system_design' "$clinic/04-proof.tests.py" || fail "$clinic capstone proof lacks rich ecosystem design assertion"; fi
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(51|52|53|54|55|56|57|58|59|60)- ]]; then
    extra=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
  elif [[ "$clinic_name" =~ ^(41|42|43|44|45|46|47|48|49|50)- ]]; then
    extra=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
  elif [[ "$clinic_name" =~ ^(31|32|33|34|35|36|37|38|39|40)- ]]; then
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


  if [[ "$clinic_name" =~ ^(61|62|63|64|65|66|67|68|69|70)- ]]; then
    for heading in "What this clinic teaches" "Creator/marketplace problem and user impact" "Named viewers/buyers/creators/sellers/listings and why each exists" "Broken ecosystem/ranking behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
      if grep -Eq 'import +(numpy|pandas|sklearn)|from +(numpy|pandas|sklearn)' "$file"; then fail "$file imports non-scope marketplace dependency"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +expected\["marketplace_rankings"\]|return +expected\["creator_rankings"\]|return +expected\["seller_rankings"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'ecosystem_debug_trace|debug_trace' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks ecosystem_debug_trace or debug_trace assertion"
    grep -Eq 'assert_rejected|risk_suppressed_items|downranked_items|exposure_rows|fairness_rows' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks rejected/risk/downranked/exposure/fairness assertion"
    if [[ "$clinic_name" =~ ^61- ]]; then grep -q 'exposure_rows' "$clinic/04-proof.tests.py" || fail "$clinic exposure proof lacks exposure_rows assertion"; fi
    if [[ "$clinic_name" =~ ^62- ]]; then grep -q 'cold_start_rows' "$clinic/04-proof.tests.py" || fail "$clinic cold-start proof lacks cold_start_rows assertion"; fi
    if [[ "$clinic_name" =~ ^63- ]]; then grep -Eq 'long_tail_rows|popularity_bias_rows' "$clinic/04-proof.tests.py" || fail "$clinic long-tail proof lacks long_tail/popularity assertion"; fi
    if [[ "$clinic_name" =~ ^65- ]]; then grep -q 'buyer_intent_rows' "$clinic/04-proof.tests.py" || fail "$clinic buyer intent proof lacks buyer_intent_rows assertion"; fi
    if [[ "$clinic_name" =~ ^66- ]]; then grep -q 'seller_quality_rows' "$clinic/04-proof.tests.py" || fail "$clinic seller quality proof lacks seller_quality_rows assertion"; fi
    if [[ "$clinic_name" =~ ^67- ]]; then grep -q 'supply_rows' "$clinic/04-proof.tests.py" && grep -q 'demand_rows' "$clinic/04-proof.tests.py" || fail "$clinic supply demand proof lacks rows assertion"; fi
    if [[ "$clinic_name" =~ ^68- ]]; then grep -q 'trust_score_rows\|risk_score_rows' "$clinic/04-proof.tests.py" || fail "$clinic risk proof lacks trust/risk rows assertion"; fi
    if [[ "$clinic_name" =~ ^69- ]]; then grep -q 'missing_ecosystem_explanations' "$clinic/04-proof.tests.py" || fail "$clinic debugging proof lacks missing ecosystem explanation assertion"; fi
    if [[ "$clinic_name" =~ ^70- ]]; then grep -q 'ecosystem_system_design' "$clinic/04-proof.tests.py" || fail "$clinic capstone proof lacks rich ecosystem design assertion"; fi
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(51|52|53|54|55|56|57|58|59|60)- ]]; then
    for heading in "What this clinic teaches" "Safety/integrity problem and user impact" "Named users/content/reports/policies and why each exists" "Broken safety/ranking behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
      if grep -Eq 'import +(numpy|pandas|sklearn)|from +(numpy|pandas|sklearn)' "$file"; then fail "$file imports non-scope safety dependency"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +expected\["safe_feed"\]|return +expected\["policy_decisions"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'assert_equal\(result\.get\("(safe_feed|final_feed|policy_decisions|corrected_feed)' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks exact safe/final output assertion"
    grep -Eq 'assert_rejected|downranked_items|informed_items|review_queue|reversal_rows|restored_items|regression_checks' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks rejected/downranked/informed/review/reversal assertion"
    grep -q 'safety_debug_trace' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks safety_debug_trace assertion"
    if [[ "$clinic_name" =~ ^51- ]]; then grep -q 'policy_decisions' "$clinic/04-proof.tests.py" || fail "$clinic policy taxonomy proof lacks policy_decisions assertion"; fi
    if [[ "$clinic_name" =~ ^55- ]]; then
      grep -q 'trust_score_rows' "$clinic/04-proof.tests.py" || fail "$clinic trust proof lacks trust_score_rows assertion"
      grep -q 'risk_score_rows' "$clinic/04-proof.tests.py" || fail "$clinic trust proof lacks risk_score_rows assertion"
    fi
    if [[ "$clinic_name" =~ ^(53|54)- ]]; then grep -q 'evidence_rows' "$clinic/04-proof.tests.py" || fail "$clinic abuse proof lacks evidence_rows assertion"; fi
    if [[ "$clinic_name" =~ ^56- ]]; then grep -q 'review_queue' "$clinic/04-proof.tests.py" || fail "$clinic review proof lacks review_queue assertion"; fi
    if [[ "$clinic_name" =~ ^58- ]]; then grep -q 'audit_log' "$clinic/04-proof.tests.py" || fail "$clinic appeal proof lacks audit_log assertion"; fi
    if [[ "$clinic_name" =~ ^59- ]]; then grep -q 'regression_checks' "$clinic/04-proof.tests.py" || fail "$clinic incident proof lacks regression_checks assertion"; fi
    if [[ "$clinic_name" =~ ^60- ]]; then grep -q 'safety_system_design' "$clinic/04-proof.tests.py" || fail "$clinic capstone proof lacks design object assertion"; fi
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(41|42|43|44|45|46|47|48|49|50)- ]]; then
    for heading in "What this clinic teaches" "Graph problem and user intent" "Named users/items/communities/edges and why each exists" "Broken graph behavior" "Exact wrong result from the broken version" "Correct result from the solution" "Proof assertions" "Beginner mental model" "Senior engineering review angle" "What the learner should notice" "Interview explanation target"; do
      grep -q "$heading" "$clinic/00-design.md" || fail "$clinic design missing $heading"
    done
    for file in "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py"; do
      if grep -Eq 'clinic\.startswith\(|data\["clinic"\]\.startswith\(|if clinic in|if clinic ==' "$file"; then fail "$file contains dispatcher shortcut"; fi
      if grep -Eq 'import +(numpy|pandas|sklearn|networkx|igraph|graphframes)|from +(numpy|pandas|sklearn|networkx|igraph|graphframes)' "$file"; then fail "$file imports non-scope graph dependency"; fi
    done
    if grep -Eq 'return +expected\["final_feed"\]|return +expected\["graph_candidates"\]|return +data\["expected"\]|return +expected($|[^A-Za-z0-9_])' "$clinic/03-solution.py"; then fail "$clinic solution returns expected directly"; fi
    grep -Eq 'assert_equal\(result\.get\("(final_candidate_pool|graph_candidates|people_you_may_know)' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks exact graph candidate assertion"
    grep -Eq 'missed_graph_candidates|missing_graph_explanations|assert_rejected|not in' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks graph candidate/missed/rejected assertion"
    grep -q 'graph_debug_trace' "$clinic/04-proof.tests.py" || fail "$clinic proof lacks graph_debug_trace assertion"
    if [[ "$clinic_name" =~ ^42- ]]; then grep -q 'mutual_rows' "$clinic/04-proof.tests.py" || fail "$clinic mutual proof lacks mutual_rows assertion"; fi
    if [[ "$clinic_name" =~ ^44- ]]; then grep -q 'random_walk_rows' "$clinic/04-proof.tests.py" || fail "$clinic random-walk proof lacks random_walk_rows assertion"; fi
    if [[ "$clinic_name" =~ ^45- ]]; then grep -q 'authority_rows' "$clinic/04-proof.tests.py" || fail "$clinic authority proof lacks authority_rows assertion"; fi
    if [[ "$clinic_name" =~ ^46- ]]; then grep -q 'community_rows' "$clinic/04-proof.tests.py" || fail "$clinic community proof lacks community_rows assertion"; fi
    if [[ "$clinic_name" =~ ^47- ]]; then grep -q 'heterogeneous_path_rows' "$clinic/04-proof.tests.py" || fail "$clinic heterogeneous proof lacks heterogeneous_path_rows assertion"; fi
    grep -q '| Mutation | Expected failing proof |' "$clinic/13-mutation-checks.md" || fail "$clinic mutation file missing table"
    mutation_rows="$(grep -Ec '^\| [^|-]' "$clinic/13-mutation-checks.md")"
    [[ "$mutation_rows" -ge 6 ]] || fail "$clinic mutation file needs at least 5 rows"
    grep -q 'Review questions' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Review questions"
    grep -q 'Telemetry' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing Telemetry"
    grep -q 'Do not over-engineer yet' "$clinic/11-senior-review-notes.md" || fail "$clinic senior review missing restraint note"
  elif [[ "$clinic_name" =~ ^(31|32|33|34|35|36|37|38|39|40)- ]]; then
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
grep -q "0.5 \* 0.7 = 0.35" 03-feeds-ranking-redone/00-graph-algorithms-for-beginners.md || fail "root docs define graph algorithms without numeric/path example"
grep -q "Ada -> backend_club -> javaconf" 03-feeds-ranking-redone/00-graph-debugging-playbook.md || fail "root docs define graph tracing without path example"
grep -q "post_201 has spam_scam" 03-feeds-ranking-redone/00-safety-integrity-for-beginners.md || fail "root docs define safety without row-level example"
grep -q "Ada 0.9 and Ben 0.8" 03-feeds-ranking-redone/00-abuse-and-trust-debugging-playbook.md || fail "root docs define trust without score/evidence example"

grep -q "creator_maya has 0 historical exposure" 03-feeds-ranking-redone/00-exposure-fairness-and-popularity-bias.md || fail "root docs define fairness without exposure example"
grep -q "response time, cancellation rate, dispute rate, completed jobs, and fulfilment quality" 03-feeds-ranking-redone/00-marketplace-ranking-for-beginners.md || fail "root docs define marketplace trust without score components"
if find 03-feeds-ranking-redone -maxdepth 1 -type d -name '7[1-9]-*' | grep -q .; then fail "clinics 71-80 must not be added"; fi
if grep -RIEq "import +(numpy|pandas|sklearn|faiss|annoy|hnswlib|networkx|igraph|graphframes)|from +(numpy|pandas|sklearn|faiss|annoy|hnswlib|networkx|igraph|graphframes)" 03-feeds-ranking-redone scripts; then fail "non-scope ML/vector/graph dependency imported"; fi

echo "PASS feeds redone quality gate"
