# Design

## What this clinic teaches

Design a retrieval layer with lexical, semantic, two-tower, ANN, hybrid blending, cold-start, evaluation, debugging, freshness checks, and ranking handoff.

## Retrieval problem and user intent

Ada needs a reliable candidate pool before ranking. The system must retrieve from multiple sources, reject unsafe rows, explain missing candidates, and hand a rich contract to ranking.

## Named users/items/sources and why each exists

- Item: 101 followed backend item
- Why it exists: followed source in final pool
- Simulation/proof that uses it: Proof asserts 101 candidate source followed_author
- Wrong behavior if removed: Capstone no longer proves followed source.
- Item: 201 lexical Java testing item
- Why it exists: lexical retrieval in final pool
- Simulation/proof that uses it: Proof asserts 201 lexical source
- Wrong behavior if removed: Capstone no longer proves lexical source.
- Item: 301 semantic backend item
- Why it exists: semantic retrieval in final pool
- Simulation/proof that uses it: Proof asserts 301 semantic source
- Wrong behavior if removed: Capstone no longer proves semantic source.
- Item: 401 two-tower high-similarity item
- Why it exists: two-tower retrieval in final pool
- Simulation/proof that uses it: Proof asserts 401 two_tower score
- Wrong behavior if removed: Capstone no longer proves two-tower source.
- Item: 501 ANN approximate candidate
- Why it exists: ANN retrieval in final pool
- Simulation/proof that uses it: Proof asserts 501 ann source
- Wrong behavior if removed: Capstone no longer proves ANN source.
- Item: 601 cold-start backfill item
- Why it exists: cold-start retrieval in final pool
- Simulation/proof that uses it: Proof asserts 601 cold_start_backfill
- Wrong behavior if removed: Capstone no longer proves cold-start.
- Item: 701 blocked item
- Why it exists: shared retrieval safety rejection
- Simulation/proof that uses it: Proof asserts 701 blocked_author
- Wrong behavior if removed: Capstone no longer proves safety.
- Item: 801 unsafe item
- Why it exists: shared retrieval safety rejection
- Simulation/proof that uses it: Proof asserts 801 unsafe_content
- Wrong behavior if removed: Capstone no longer proves safety.
- Item: 901 stale index miss
- Why it exists: missing explanation for index freshness
- Simulation/proof that uses it: Proof asserts 901 index_not_fresh
- Wrong behavior if removed: Capstone no longer proves index freshness.
- Item: 1001 ANN bucket miss
- Why it exists: missing explanation for ANN probe
- Simulation/proof that uses it: Proof asserts 1001 ann_bucket_not_probed
- Wrong behavior if removed: Capstone no longer proves ANN probe.

## Broken retrieval behavior

Broken capstone uses one retrieval source only, leaks blocked/unsafe items, omits missing-candidate explanations, produces a boolean-only design object, and omits ranking handoff.

## Exact wrong result from the broken version

final_candidate_pool contains only one-source candidates plus unsafe rows; missing explanations and ranking handoff are empty; retrieval_system_design is boolean-only.

## Correct result from the solution

final_candidate_pool [101, 201, 301, 401, 501, 601], rejected 701/801, missing 901/1001, rich nested retrieval_system_design, and ranking_handoff_contract with IDs, sources, scores, and traces.

## Proof assertions

Exact final pool, exact rejected items, exact missing explanations, rich nested policies, ranking handoff fields, and debug traces for kept/rejected/missing items.

## Beginner mental model

A senior retrieval system is not one search query. It is a set of retrieval sources, safety checks, freshness policies, evaluation reports, missing-candidate explanations, and a handoff contract to ranking.

## Senior engineering review angle

Review whether each source has a purpose and failure mode, whether policies are inspectable, and whether ranking receives enough context to debug downstream output.

## What the learner should notice

The design object must carry semantics: policies, thresholds, owners, failure modes, and contracts rather than booleans.

## Interview explanation target

Walk through sources, safety, blending, missing-candidate debugging, evaluation, and handoff to ranking with exact item IDs.
