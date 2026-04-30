# Design

## What this clinic teaches

Compare exact token matching with meaning-based topic retrieval for a Java testing query.

## Retrieval problem and user intent

Ada needs retrieval to find candidate items before ranking can order them. This clinic keeps the corpus tiny so every found, missed, and rejected item can be inspected.

## Named users/items/sources and why each exists

- Item: 101 Java unit testing with JUnit
- Why it exists: matches lexical and semantic retrieval
- Simulation/proof that uses it: Proof asserts 101 in both match lists
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 201 Spring Boot integration tests
- Why it exists: semantic match without Java token
- Simulation/proof that uses it: Proof asserts 201 semantic reason
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 301 JavaScript testing guide
- Why it exists: language trap for naive lexical retrieval
- Simulation/proof that uses it: Proof asserts 301 language_trap_javascript
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 401 Testcontainers for backend services
- Why it exists: semantic backend testing match
- Simulation/proof that uses it: Proof asserts 401 semantic reason
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 501 Developer memes
- Why it exists: query mismatch rejection
- Simulation/proof that uses it: Proof asserts 501 query_mismatch
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 601 Reliable test suites in Java
- Why it exists: lexical and semantic Java testing match
- Simulation/proof that uses it: Proof asserts 601 high pool order
- Wrong behavior if removed: One retrieval proof loses coverage.
- Item: 701 blocked author exact-match post
- Why it exists: blocked exact match must not leak
- Simulation/proof that uses it: Proof asserts 701 blocked_author
- Wrong behavior if removed: One retrieval proof loses coverage.

## Broken retrieval behavior

Broken uses lexical only, includes JavaScript 301, misses 201/401, and leaks blocked 701.

## Exact wrong result from the broken version

Broken uses lexical only, includes JavaScript 301, misses 201/401, and leaks blocked 701.

## Correct result from the solution

lexical_matches [101, 301, 601], semantic_matches [101, 201, 401, 601], final_candidate_pool [101, 601, 201, 401].

## Proof assertions

Exact lexical and semantic lists, exact final pool, 301/501/701 rejection reasons, semantic trace for 201 and 401.

## Beginner mental model

Retrieval decides what ranking is allowed to score. A missing candidate is often a retrieval bug, not a ranking decision.

## Senior engineering review angle

Review source labels, vector or match calculations, miss reasons, recall risk, and the handoff contract.

## What the learner should notice

A candidate pool is only trustworthy when it explains which source found each item and why other items did not arrive.

## Interview explanation target

Explain the corpus, source, match rule, excluded rows, recall bug, and proof that blocks shortcut answers.
