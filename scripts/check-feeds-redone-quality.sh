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
)

shared_files=(
  03-feeds-ranking-redone/_shared/import_simulation.py
  03-feeds-ranking-redone/_shared/assertions.py
  03-feeds-ranking-redone/_shared/result_contract.py
  03-feeds-ranking-redone/_shared/scoring_math.py
  03-feeds-ranking-redone/_shared/trace_helpers.py
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
)

for file in "${root_files[@]}" "${shared_files[@]}"; do
  [[ -s "$file" ]] || fail "missing required file $file"
done

for clinic in "${clinics[@]}"; do
  [[ -d "$clinic" ]] || fail "missing clinic $clinic"
  common=(README.md 00-design.md 00-scenario.md 01-dataset.json 02-broken_simulation.py 03-solution.py 04-proof.tests.py 05-debugging-notes.md 06-break-fix-drills.md 07-interview-explanation.md 08-what-to-notice.md 09-evidence-map.md)
  for file in "${common[@]}"; do [[ -s "$clinic/$file" ]] || fail "missing $clinic/$file"; done
  clinic_name="$(basename "$clinic")"
  if [[ "$clinic_name" =~ ^(11|12|13|14|15|16|17|18|19|20)- ]]; then
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

  if [[ "$clinic_name" =~ ^(11|12|13|14|15|16|17|18|19|20)- ]]; then
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
)
for phrase in "${banned[@]}"; do
  if grep -Riq "$phrase" 03-feeds-ranking-redone; then fail "banned fake-depth phrase found: $phrase"; fi
done

echo "PASS feeds redone quality gate"
