# Beginner Walkthrough

## Retrieval problem this clinic solves

Compare exact token matching with meaning-based topic retrieval for a Java testing query.

## Why beginners confuse retrieval with ranking

They ask why ranking did not choose an item even when retrieval never handed that item to ranking.

## What the broken system did

Broken uses lexical only, includes JavaScript 301, misses 201/401, and leaks blocked 701.

## What the corrected system did

lexical_matches [101, 301, 601], semantic_matches [101, 201, 401, 601], final_candidate_pool [101, 601, 201, 401].

## Which rows/items prove the lesson

101 Java unit testing with JUnit, 201 Spring Boot integration tests, 301 JavaScript testing guide, 401 Testcontainers for backend services, 501 Developer memes, 601 Reliable test suites in Java, 701 blocked author exact-match post

## One tiny retrieval calculation

Query tokens are java and testing; 201 has no java token but shares semantic topic java_testing, so semantic retrieval finds it.
