#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/50-senior-social-graph-recommendation-system-design-capstone
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/41-social-graph-data-model
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/42-mutual-friends-triangle-closing
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/44-random-walk-recommendation-intuition
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/46-community-detection-interest-clusters
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/49-graph-candidate-debugging-why-missing
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/50-senior-social-graph-recommendation-system-design-capstone
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
