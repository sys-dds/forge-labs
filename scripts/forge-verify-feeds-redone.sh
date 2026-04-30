#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/30-senior-feed-system-design-capstone
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/21-offline-replay-and-golden-feed-regression
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/22-why-did-i-see-this-explanation-traces
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/26-ab-testing-and-experiment-guardrails
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/29-feed-incident-clinic
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/30-senior-feed-system-design-capstone
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
