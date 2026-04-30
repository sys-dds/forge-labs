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
03-feeds-ranking-redone/11-following-feed-vs-for-you-feed
03-feeds-ranking-redone/12-short-video-ranking-patterns
03-feeds-ranking-redone/13-youtube-style-home-and-up-next
03-feeds-ranking-redone/14-hot-ranking-reddit-hacker-news-patterns
03-feeds-ranking-redone/15-linkedin-professional-feed-ranking
03-feeds-ranking-redone/16-marketplace-recommendation-ranking
03-feeds-ranking-redone/17-search-ranking-vs-feed-ranking
03-feeds-ranking-redone/18-creator-discovery-and-cold-start
03-feeds-ranking-redone/19-safety-integrity-ranking
03-feeds-ranking-redone/20-beginner-ranking-maths-and-score-debugging
03-feeds-ranking-redone/21-offline-replay-and-golden-feed-regression
03-feeds-ranking-redone/22-why-did-i-see-this-explanation-traces
03-feeds-ranking-redone/23-why-did-i-not-see-this-missing-item-debugger
03-feeds-ranking-redone/24-feedback-loops-and-echo-chamber-simulator
03-feeds-ranking-redone/25-ranking-metrics-for-beginners
03-feeds-ranking-redone/26-ab-testing-and-experiment-guardrails
03-feeds-ranking-redone/27-pre-ranking-reranking-and-latency-budget
03-feeds-ranking-redone/28-freshness-stale-candidates-and-already-seen-filtering
03-feeds-ranking-redone/29-feed-incident-clinic
03-feeds-ranking-redone/30-senior-feed-system-design-capstone
CLINICS
