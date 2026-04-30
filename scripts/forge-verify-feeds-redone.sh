#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/60-senior-safety-aware-feed-ranking-system-design-capstone
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/51-safety-policy-decision-taxonomy
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/53-spam-clickbait-engagement-farming-suppression
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/54-fake-engagement-bot-rings-coordinated-abuse
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/56-reporter-reliability-review-queues
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/58-appeals-reversals-audit-lineage
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/60-senior-safety-aware-feed-ranking-system-design-capstone
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
