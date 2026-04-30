# Retrieval Systems Map

## Layer order

1. Corpus: all searchable feed items.
2. Source registry: followed, lexical, semantic, two-tower, ANN, trending, exploration, cold-start.
3. Retrieval eligibility: blocked, muted, unsafe, stale, and source-specific filters.
4. Similarity or match rows: tokens, dot product, cosine, distance, pair score, or profile match.
5. Source blending: quotas, dedupe, multi-source reasons, and exploration backfill.
6. Evaluation: recall, precision, false positives, false negatives, and replay.
7. Missing-candidate debugger: index freshness, embedding version, quota overflow, tokenization miss, ANN bucket miss.
8. Ranking handoff: candidate IDs, sources, scores, and traces.

## Clinic map

- Clinics 01-10: feed pipeline foundations.
- Clinics 11-20: product surface ranking patterns.
- Clinics 21-30: evaluation, experiments, incidents, and senior feed design.
- Clinics 31-40: advanced retrieval, embeddings, ANN, hybrid search, recall debugging, and retrieval design.

## Future feed expansions

- Social graph, communities, and graph algorithms.
- Safety, integrity, abuse, and trust ranking.
- Creator ecosystem and marketplace ranking depth.

No movement to another track should happen without user approval.
