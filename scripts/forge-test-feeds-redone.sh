#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

clinic="${1:-}"
if [[ -z "$clinic" || ! -d "$clinic" ]]; then
  echo "Usage: $0 03-feeds-ranking-redone/<clinic>" >&2
  exit 1
fi

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

for file in "${required[@]}"; do
  if [[ ! -s "$clinic/$file" ]]; then
    echo "Missing required file: $clinic/$file" >&2
    exit 1
  fi
done

python3 -m json.tool "$clinic/01-dataset.json" >/dev/null

echo "Testing broken simulation for $clinic"
python3 "$clinic/04-proof.tests.py" "$clinic/02-broken_simulation.py" --expect-failure

echo "Testing solution simulation for $clinic"
python3 "$clinic/04-proof.tests.py" "$clinic/03-solution.py" --expect-success

echo "PASS feeds redone clinic proof: $clinic"
