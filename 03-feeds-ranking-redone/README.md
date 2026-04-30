# Feeds Ranking Redone

This path follows SQL Redone. SQL Redone teaches query correctness; Feeds Ranking Redone teaches deterministic feed and recommendation simulations: inventory, eligibility, candidate generation, feature rows, scoring, mixing, pagination-shaped pages, feedback, and evaluation.

It does not replace `01-sql/`, `01-sql-redone/`, `02-postgres/`, or PostgreSQL Redone if that path exists. It does not add Java, Spring, Redis, Kafka, notebooks, or ML libraries.

Run all clinics:

```sh
./scripts/forge-test-all-feeds-redone.sh
```

Study one clinic by reading its scenario and dataset, running the broken proof, reading the debugging notes, then running the solution proof.

Recommended order:

1. 03-feeds-ranking-redone/01-feed-pipeline-mental-model
2. 03-feeds-ranking-redone/02-social-graph-candidate-generation
3. 03-feeds-ranking-redone/03-out-of-network-recommendations
4. 03-feeds-ranking-redone/04-candidate-mixing-deduplication
5. 03-feeds-ranking-redone/05-ranking-signals-feature-rows
6. 03-feeds-ranking-redone/06-scoring-models-multi-objective-ranking
7. 03-feeds-ranking-redone/07-diversity-exploration-mixing
8. 03-feeds-ranking-redone/08-stories-ephemeral-content-snapchat-patterns
9. 03-feeds-ranking-redone/09-recommended-notifications
10. 03-feeds-ranking-redone/10-feed-evaluation-debugging-simulation

What each clinic teaches: pipeline stages, social graph recall, out-of-network retrieval, dedupe/mixing, feature rows, multi-objective scoring, diversity, stories and vertical feeds, recommended notifications, and replay/debugging.

Intentionally not included yet: embeddings, ANN retrieval, online learning, experiments, model training, distributed fanout infrastructure, or company-specific algorithms.

## Hardening note
Clinics 01-10 now avoid dispatcher shortcuts. Each clinic owns its broken simulation, solution functions, proof tests, evidence map, and mutation checks. Do not add 011-020 until this foundation has been reviewed.

## Part Two

Clinics 01-10 cover feed pipeline foundations. Clinics 11-20 add product surface ranking patterns: Following vs For You, short video, Home vs Up Next, hot ranking, professional feeds, marketplace, search, creator discovery, safety, and beginner score debugging. New clinics avoid dispatcher shortcuts and keep behavior inside clinic-specific functions.
