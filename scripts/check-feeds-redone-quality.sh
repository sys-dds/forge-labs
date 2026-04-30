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
)

for file in "${root_files[@]}"; do
  [[ -s "$file" ]] || fail "missing root doc $file"
done

shared_files=(
  03-feeds-ranking-redone/_shared/simulation_contract.py
  03-feeds-ranking-redone/_shared/import_simulation.py
  03-feeds-ranking-redone/_shared/assertions.py
  03-feeds-ranking-redone/_shared/quality_helpers.py
)

for file in "${shared_files[@]}"; do
  [[ -s "$file" ]] || fail "missing shared contract file $file"
done

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
)

required=(
  README.md
  00-design.md
  00-scenario.md
  01-dataset.json
  02-broken_simulation.py
  03-solution.py
  04-proof.tests.py
  05-debugging-notes.md
  06-break-fix-drills.md
  07-interview-explanation.md
  08-what-to-notice.md
  09-evidence-map.md
)

design_headings=(
  "What this clinic teaches"
  "Named users/content and why each exists"
  "Broken ranking behavior"
  "Exact wrong result from the broken version"
  "Correct result from the solution"
  "Proof assertions"
  "What the learner should notice"
  "Interview explanation target"
)

interview_headings=(
  "Direct answer"
  "Dataset walkthrough"
  "Ranking reasoning"
  "Common mistake"
  "Senior trade-off"
  "Follow-up answer"
)

for clinic in "${clinics[@]}"; do
  [[ -d "$clinic" ]] || fail "missing clinic $clinic"
  for file in "${required[@]}"; do
    [[ -s "$clinic/$file" ]] || fail "missing required file $clinic/$file"
  done

  python3 -m json.tool "$clinic/01-dataset.json" >/dev/null || fail "invalid JSON $clinic/01-dataset.json"
  PYTHONPYCACHEPREFIX=/tmp/forge-feeds-redone-pycache python3 -m py_compile "$clinic/02-broken_simulation.py" "$clinic/03-solution.py" "$clinic/04-proof.tests.py" || fail "python file failed to compile in $clinic"

  for heading in "${design_headings[@]}"; do
    grep -q "$heading" "$clinic/00-design.md" || fail "$clinic/00-design.md missing heading $heading"
  done

  wrong_count="$(grep -c "Wrong behavior if removed:" "$clinic/00-design.md")"
  [[ "$wrong_count" -ge 6 ]] || fail "$clinic/00-design.md needs at least 6 Wrong behavior if removed entries"

  grep -q '| Item | Exists because | Used by proof | Used by debug trace | Used by drill |' "$clinic/09-evidence-map.md" || fail "$clinic/09-evidence-map.md missing required table header"
  evidence_rows="$(grep -Ec '^\| [^|-]' "$clinic/09-evidence-map.md")"
  [[ "$evidence_rows" -ge 7 ]] || fail "$clinic/09-evidence-map.md needs at least 6 item rows"

  for heading in "${interview_headings[@]}"; do
    grep -q "$heading" "$clinic/07-interview-explanation.md" || fail "$clinic/07-interview-explanation.md missing $heading"
  done

  drill_count="$(grep -Ec '^[0-9]+\. ' "$clinic/06-break-fix-drills.md")"
  [[ "$drill_count" -ge 5 ]] || fail "$clinic/06-break-fix-drills.md needs at least 5 drills"

  mention_count="$(grep -Eo 'Ada|Ben|Cy|Noor|Diya|Lina|Omar|Maya|Theo|101|102|201|301|401|501|502|601|701|801|901|1001|ben_posted|maya_thread|lina_similar_topic|noor_blocked' "$clinic/05-debugging-notes.md" | sort -u | wc -l | tr -d ' ')"
  [[ "$mention_count" -ge 5 ]] || fail "$clinic/05-debugging-notes.md must mention at least 5 named users/content IDs"

  if grep -Eiq "assertion failed|^failed$|^wrong$" "$clinic/04-proof.tests.py"; then
    fail "$clinic/04-proof.tests.py contains generic proof failure text"
  fi
  grep -q "expected\\[\"final_feed\"\\]" "$clinic/04-proof.tests.py" || fail "$clinic/04-proof.tests.py must contain exact expected output checks"
  grep -q "rejected" "$clinic/04-proof.tests.py" || fail "$clinic/04-proof.tests.py must assert rejected items"
  grep -q "debug_trace" "$clinic/04-proof.tests.py" || fail "$clinic/04-proof.tests.py must assert debug_trace"
  grep -Eq "expected .*\\[[0-9a-zA-Z_, -]+\\]|content ID|701|501|101|ben_posted|maya_thread" "$clinic/04-proof.tests.py" || fail "$clinic/04-proof.tests.py failure messages must name expected output or a specific content ID"
done

banned=(
  "Row group"
  "Teaching row"
  "anchors a row"
  "concrete case"
  "This breaks backend behavior"
  "This chapter teaches an important concept"
  "real-world backend pattern"
  "useful in real systems"
  "production systems need this"
  "ranking is important"
  "recommendations are important"
  "social apps use this"
  "this is a common pattern"
  "weak proof"
  "generic feed"
  "generic ranking"
  "generic candidate"
  "positive case"
  "negative case"
  "edge case"
  "realistic scenario"
)

for phrase in "${banned[@]}"; do
  if grep -Riq "$phrase" 03-feeds-ranking-redone; then
    fail "banned fake-depth phrase found: $phrase"
  fi
done

echo "PASS feeds redone quality gate"
