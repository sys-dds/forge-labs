#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

./scripts/forge-list-feeds-redone.sh
./scripts/forge-inspect-feeds-redone.sh 03-feeds-ranking-redone/10-feed-evaluation-debugging-simulation
./scripts/forge-test-feeds-redone.sh 03-feeds-ranking-redone/10-feed-evaluation-debugging-simulation
./scripts/forge-test-all-feeds-redone.sh
./scripts/check-feeds-redone-quality.sh

echo "Git-safe reminder: inspect git status and diff before committing."
echo "PASS feeds redone verification"
