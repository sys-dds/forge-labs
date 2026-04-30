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

clinic_name="$(basename "$clinic")"
if [[ "$clinic_name" =~ ^(31|32|33|34|35|36|37|38|39|40)- ]]; then
  extra_required=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
elif [[ "$clinic_name" =~ ^(21|22|23|24|25|26|27|28|29|30)- ]]; then
  extra_required=(10-beginner-walkthrough.md 11-senior-review-notes.md 12-shortcut-audit.md 13-mutation-checks.md)
elif [[ "$clinic_name" =~ ^(11|12|13|14|15|16|17|18|19|20)- ]]; then
  extra_required=(10-beginner-walkthrough.md 11-shortcut-audit.md 12-mutation-checks.md)
else
  extra_required=(10-mutation-checks.md)
fi

for file in "${extra_required[@]}"; do
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
