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


## Retrieval Slice

Clinics 01-10 cover feed pipeline foundations. Clinics 11-20 cover product surface ranking patterns. Clinics 21-30 cover evaluation, experiments, incidents, and senior design. Clinics 31-40 cover advanced retrieval, embeddings, ANN trade-offs, hybrid source blending, recall debugging, and retrieval system design. Stay on Feeds/Ranking Redone unless the user explicitly approves a track move. Future feed expansions can cover social graph/community algorithms, safety and trust ranking, and creator ecosystem depth.

Clinics 41-50 add social graph, communities, graph algorithms, mutuals, graph retrieval, and community recommendations while staying inside Feeds/Ranking Redone.

Clinics 51-60 add safety, integrity, abuse, trust ranking, policy treatment, review queues, appeals, and safety-aware feed design while staying inside Feeds/Ranking Redone.
## Creator And Marketplace Ecosystem Clinics

Clinics 01-10 cover feed pipeline foundations; 11-20 product surface ranking patterns; 21-30 evaluation, experiments, incidents, and senior design; 31-40 advanced retrieval, embeddings, ANN, and recall debugging; 41-50 social graph, communities, and graph algorithms; 51-60 safety, integrity, abuse, and trust ranking; 61-70 creator ecosystem and marketplace ranking depth. Stay on Feeds/Ranking Redone unless the user approves moving to another track. At clinic 70, Feeds/Ranking Redone is feature-complete unless review asks for another feed expansion.
