#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

while IFS= read -r clinic; do
  ./scripts/forge-test-feeds-redone.sh "$clinic"
done < <(./scripts/forge-list-feeds-redone.sh)

echo "PASS all feeds redone clinics"
