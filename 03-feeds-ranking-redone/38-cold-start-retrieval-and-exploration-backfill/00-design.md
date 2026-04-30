# Design

## What this clinic teaches

Recover new high-quality creators that pure engagement retrieval would miss, while filtering unsafe and unrelated rows.

## Retrieval problem and user intent

Ada needs retrieval to produce a candidate pool before ranking. The clinic records found items, missed candidates, rejected rows, and debug traces.

## Named users/items/sources and why each exists

- Item: 101 popular backend post
- Why it exists: popular engagement candidate
- Simulation/proof that uses it: Proof asserts 101 retrieved
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 201 popular movie post
- Why it exists: second popular candidate
- Simulation/proof that uses it: Proof asserts 201 retrieved
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 301 new backend creator
- Why it exists: cold-start backfill no likes
- Simulation/proof that uses it: Proof asserts 301 backfill reason
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 401 cooking creator
- Why it exists: low interest rejection
- Simulation/proof that uses it: Proof asserts 401 low_user_interest_match
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 501 unsafe new creator
- Why it exists: safety filter for cold-start
- Simulation/proof that uses it: Proof asserts 501 unsafe_new_creator
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 601 profile-topic new creator
- Why it exists: cold-start profile match
- Simulation/proof that uses it: Proof asserts 601 backfill reason
- Wrong behavior if removed: Retrieval coverage gets weaker.
- Item: 701 old popular unrelated
- Why it exists: popular but unrelated rejection
- Simulation/proof that uses it: Proof asserts 701 unrelated_popular_item
- Wrong behavior if removed: Retrieval coverage gets weaker.

## Broken retrieval behavior

Broken retrieves only popular items, misses 301/601, includes unrelated 701, and includes unsafe 501.

## Exact wrong result from the broken version

Broken retrieves only popular items, misses 301/601, includes unrelated 701, and includes unsafe 501.

## Correct result from the solution

retrieved_candidates [101, 201, 301, 601], cold_start_backfill [301, 601], exact rejections.

## Proof assertions

Cold-start items included, unsafe new creator rejected, unrelated popular rejected, backfill reasons and no-engagement traces present.

## Beginner mental model

Retrieval is not ranking. It is the earlier step that decides which candidates ranking may score.

## Senior engineering review angle

Review source coverage, cold-start or missing-candidate reasons, freshness checks, and the handoff contract to ranking.

## What the learner should notice

The retrieval layer needs its own observability because ranking logs cannot explain items retrieval never found.

## Interview explanation target

Explain the corpus, source rules, excluded items, recall bug, debug trace, and proof that blocks shortcuts.
