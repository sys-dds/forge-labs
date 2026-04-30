#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

cat <<'CLINICS'
03-feeds-ranking-redone/01-feed-pipeline-mental-model
03-feeds-ranking-redone/02-social-graph-candidate-generation
03-feeds-ranking-redone/03-out-of-network-recommendations
03-feeds-ranking-redone/04-candidate-mixing-deduplication
03-feeds-ranking-redone/05-ranking-signals-feature-rows
03-feeds-ranking-redone/06-scoring-models-multi-objective-ranking
03-feeds-ranking-redone/07-diversity-exploration-mixing
03-feeds-ranking-redone/08-stories-ephemeral-content-snapchat-patterns
03-feeds-ranking-redone/09-recommended-notifications
03-feeds-ranking-redone/10-feed-evaluation-debugging-simulation
CLINICS
