#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/40-senior-retrieval-system-design-capstone
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/31-retrieval-funnel-mental-model
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/33-embeddings-for-beginners
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/35-approximate-nearest-neighbour-mental-model
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/37-retrieval-recall-precision-evaluation
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/39-retrieval-debugging-why-candidate-was-missing
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/40-senior-retrieval-system-design-capstone
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
