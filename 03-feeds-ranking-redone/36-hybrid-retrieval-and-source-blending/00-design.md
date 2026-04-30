# Design

## What this clinic teaches

Blend followed, lexical, semantic, trending, and exploration sources while preserving source reasons and relevance quotas.

## Retrieval problem and user intent

Ada needs a candidate pool before ranking. This clinic makes the retrieval sources, missed candidates, and excluded items inspectable.

## Named users/items/sources and why each exists

- Item: 101 followed backend post
- Why it exists: followed source anchor
- Simulation/proof that uses it: Proof asserts 101 followed_author
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 201 lexical Java testing post
- Why it exists: lexical source candidate
- Simulation/proof that uses it: Proof asserts 201 lexical
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 301 semantic testing post
- Why it exists: semantic source candidate
- Simulation/proof that uses it: Proof asserts 301 semantic
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 401 trending unrelated post
- Why it exists: quota/relevance rejection
- Simulation/proof that uses it: Proof asserts 401 low_relevance_trending
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 501 exploration new creator
- Why it exists: exploration source preserved
- Simulation/proof that uses it: Proof asserts 501 exploration
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 601 lexical plus semantic
- Why it exists: multi-source reason preservation
- Simulation/proof that uses it: Proof asserts both reasons
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 701 blocked trending post
- Why it exists: blocked rejection
- Simulation/proof that uses it: Proof asserts 701 blocked_author
- Wrong behavior if removed: A retrieval proof loses coverage.
- Item: 801 unsafe high-trending post
- Why it exists: unsafe rejection
- Simulation/proof that uses it: Proof asserts 801 unsafe_content
- Wrong behavior if removed: A retrieval proof loses coverage.

## Broken retrieval behavior

Broken uses trending only, loses 601 multi-source reasons, includes blocked/unsafe items, and omits exploration 501.

## Exact wrong result from the broken version

Broken uses trending only, loses 601 multi-source reasons, includes blocked/unsafe items, and omits exploration 501.

## Correct result from the solution

hybrid_candidates [101, 601, 201, 301, 501] with source reasons and exact rejections.

## Proof assertions

Exact hybrid pool, 601 lexical + semantic reason, trending relevance rejection, blocked/unsafe rejection, and source-blending trace.

## Beginner mental model

Retrieval finds the pool; ranking orders the pool. A candidate missing from retrieval cannot be rescued later by ranking.

## Senior engineering review angle

Review source coverage, miss reasons, recall and precision, index freshness, and the ranking handoff contract.

## What the learner should notice

Good retrieval infrastructure explains both successful candidates and absent candidates.

## Interview explanation target

Explain the corpus, retrieval sources, matching rule, excluded items, recall risk, and shortcut-proof tests.
