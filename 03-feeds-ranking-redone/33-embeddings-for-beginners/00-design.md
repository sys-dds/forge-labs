# Design

## What this clinic teaches

Use hand-written user and item vectors to compute dot product and cosine similarity without ML libraries.

## Retrieval problem and user intent

Ada needs retrieval to find candidate items before ranking can order them. This clinic keeps the corpus tiny so every found, missed, and rejected item can be inspected.

## Named users/items/sources and why each exists

- Item: Ada user vector [backend, movies, cooking]
- Why it exists: anchors vector query
- Simulation/proof that uses it: Proof asserts similarity rows use Ada vector
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 101 backend tutorial
- Why it exists: highest backend similarity
- Simulation/proof that uses it: Proof asserts 101 dot and cosine
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 201 movie ranking video
- Why it exists: secondary movie interest candidate
- Simulation/proof that uses it: Proof asserts 201 appears after mixed items
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 301 cooking post
- Why it exists: low similarity miss
- Simulation/proof that uses it: Proof asserts 301 below threshold miss
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 401 backend movie architecture
- Why it exists: mixed backend/movie similarity
- Simulation/proof that uses it: Proof asserts 401 similarity row
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 501 blocked backend post
- Why it exists: eligibility beats high similarity
- Simulation/proof that uses it: Proof asserts 501 blocked_author
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 601 exploration mixed vector
- Why it exists: mixed-interest candidate
- Simulation/proof that uses it: Proof asserts 601 similarity row
- Wrong behavior if removed: One retrieval proof loses coverage.

## Broken retrieval behavior

Broken ranks by likes, includes blocked 501, hides similarity scores, and misses mixed-interest 401.

## Exact wrong result from the broken version

Broken ranks by likes, includes blocked 501, hides similarity scores, and misses mixed-interest 401.

## Correct result from the solution

retrieved_candidates [101, 401, 601, 201], rejected 501, similarity_rows expose dot and cosine values.

## Proof assertions

Exact similarity rows for 101/401/601, exact final order, blocked rejection, threshold miss, and vector-dimension trace.

## Beginner mental model

Retrieval decides what ranking is allowed to score. A missing candidate is often a retrieval bug, not a ranking decision.

## Senior engineering review angle

Review source labels, vector or match calculations, miss reasons, recall risk, and the handoff contract.

## What the learner should notice

A candidate pool is only trustworthy when it explains which source found each item and why other items did not arrive.

## Interview explanation target

Explain the corpus, source, match rule, excluded rows, recall bug, and proof that blocks shortcut answers.
