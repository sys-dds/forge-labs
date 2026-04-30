#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

clinic="${1:-}"
if [[ -z "$clinic" || ! -d "$clinic" ]]; then
  echo "Usage: $0 03-feeds-ranking-redone/<clinic>" >&2
  exit 1
fi

echo "Clinic path: $clinic"
echo
echo "Reading order:"
for file in README.md 00-design.md 00-scenario.md 01-dataset.json 02-broken_simulation.py 03-solution.py 04-proof.tests.py 05-debugging-notes.md 06-break-fix-drills.md 07-interview-explanation.md 08-what-to-notice.md 09-evidence-map.md; do
  echo "- $clinic/$file"
done
if [[ -s "$clinic/12-mutation-checks.md" ]]; then
  for file in 10-beginner-walkthrough.md 11-shortcut-audit.md 12-mutation-checks.md; do
    echo "- $clinic/$file"
  done
else
  echo "- $clinic/10-mutation-checks.md"
fi
echo
echo "Key users/content:"
python3 - "$clinic/01-dataset.json" <<'PY'
import json
import sys

data = json.load(open(sys.argv[1]))
for item in data.get("content", [])[:8]:
    print(f"- {item.get('id')} {item.get('author', item.get('title', ''))}")
PY
echo
echo "Broken behavior:"
grep -A2 "## Exact wrong result from the broken version" "$clinic/00-design.md" | tail -n +3
echo
echo "Expected final output:"
python3 - "$clinic/01-dataset.json" <<'PY'
import json
import sys

data = json.load(open(sys.argv[1]))
expected = data.get("expected", {})
if expected:
    print(expected)
else:
    print("See 04-proof.tests.py exact output assertions")
PY
echo
echo "Expected rejected items:"
python3 - "$clinic/04-proof.tests.py" <<'PY'
import re
import sys

text = open(sys.argv[1]).read()
print(re.findall(r'assert_rejected\(result,\s*([^,]+),\s*"([^"]+)"', text))
PY
echo
echo "Proof command:"
echo "python3 $clinic/04-proof.tests.py $clinic/02-broken_simulation.py --expect-failure"
echo "python3 $clinic/04-proof.tests.py $clinic/03-solution.py --expect-success"
