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
03-feeds-ranking-redone/31-retrieval-funnel-mental-model
03-feeds-ranking-redone/32-lexical-vs-semantic-retrieval
03-feeds-ranking-redone/33-embeddings-for-beginners
03-feeds-ranking-redone/34-two-tower-retrieval-mental-model
03-feeds-ranking-redone/35-approximate-nearest-neighbour-mental-model
03-feeds-ranking-redone/36-hybrid-retrieval-and-source-blending
03-feeds-ranking-redone/37-retrieval-recall-precision-evaluation
03-feeds-ranking-redone/38-cold-start-retrieval-and-exploration-backfill
03-feeds-ranking-redone/39-retrieval-debugging-why-candidate-was-missing
03-feeds-ranking-redone/40-senior-retrieval-system-design-capstone
03-feeds-ranking-redone/41-social-graph-data-model
03-feeds-ranking-redone/42-mutual-friends-triangle-closing
03-feeds-ranking-redone/43-bipartite-user-item-collaborative-filtering
03-feeds-ranking-redone/44-random-walk-recommendation-intuition
03-feeds-ranking-redone/45-pagerank-style-authority-propagation
03-feeds-ranking-redone/46-community-detection-interest-clusters
03-feeds-ranking-redone/47-heterogeneous-graph-recommendations
03-feeds-ranking-redone/48-edge-freshness-decay-interaction-strength
03-feeds-ranking-redone/49-graph-candidate-debugging-why-missing
03-feeds-ranking-redone/50-senior-social-graph-recommendation-system-design-capstone
03-feeds-ranking-redone/51-safety-policy-decision-taxonomy
03-feeds-ranking-redone/52-hard-filters-downranking-labels
03-feeds-ranking-redone/53-spam-clickbait-engagement-farming-suppression
03-feeds-ranking-redone/54-fake-engagement-bot-rings-coordinated-abuse
03-feeds-ranking-redone/55-trust-score-account-reputation-source-quality
03-feeds-ranking-redone/56-reporter-reliability-review-queues
03-feeds-ranking-redone/57-sensitive-borderline-content-context-treatment
03-feeds-ranking-redone/58-appeals-reversals-audit-lineage
03-feeds-ranking-redone/59-safety-incident-debugging-regression-checks
03-feeds-ranking-redone/60-senior-safety-aware-feed-ranking-system-design-capstone
03-feeds-ranking-redone/61-creator-exposure-budgets-popularity-bias-control
03-feeds-ranking-redone/62-cold-start-creator-ranking-exploration-slots
03-feeds-ranking-redone/63-long-tail-content-quality-audience-fit
03-feeds-ranking-redone/64-creator-fatigue-diversity-repeated-author-caps
03-feeds-ranking-redone/65-marketplace-buyer-intent-listing-relevance
03-feeds-ranking-redone/66-seller-quality-trust-fulfilment-response-ranking
03-feeds-ranking-redone/67-marketplace-supply-demand-local-availability
03-feeds-ranking-redone/68-marketplace-risk-disputes-refunds-fraud-suppression
03-feeds-ranking-redone/69-ecosystem-debugging-why-not-shown
03-feeds-ranking-redone/70-senior-creator-marketplace-ranking-system-design-capstone
CLINICS
