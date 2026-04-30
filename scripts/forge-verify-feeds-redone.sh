#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/70-senior-creator-marketplace-ranking-system-design-capstone
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/61-creator-exposure-budgets-popularity-bias-control
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/62-cold-start-creator-ranking-exploration-slots
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/65-marketplace-buyer-intent-listing-relevance
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/66-seller-quality-trust-fulfilment-response-ranking
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/68-marketplace-risk-disputes-refunds-fraud-suppression
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/70-senior-creator-marketplace-ranking-system-design-capstone
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
