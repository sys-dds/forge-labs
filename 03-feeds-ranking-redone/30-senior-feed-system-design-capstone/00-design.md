# Design

## What this clinic teaches

Assemble multiple feed surfaces behind shared safety, explanations, replay, guardrails, and system design layers.

## Product surface and operating problem

Ada uses following, For You, stories, search, notifications, and creator discovery. The capstone proves that surfaces share safety while keeping surface-specific outputs.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: Ben followed post proves following and For You surfaces
- Simulation/proof that uses it: surface assertions
- Wrong behavior if removed: following feed has no anchor

- Item: 501
- Why it exists: Lina topic post proves For You and creator discovery
- Simulation/proof that uses it: surface assertions
- Wrong behavior if removed: topic discovery disappears

- Item: 601
- Why it exists: Maya group post proves group candidate source
- Simulation/proof that uses it: surface assertion
- Wrong behavior if removed: group layer untested

- Item: 901
- Why it exists: Theo exploration post proves exploration mix and discovery
- Simulation/proof that uses it: surface assertions
- Wrong behavior if removed: exploration absent

- Item: 1101
- Why it exists: story row proves stories tray
- Simulation/proof that uses it: surface assertion
- Wrong behavior if removed: stories ignored

- Item: 1201
- Why it exists: search result proves search surface
- Simulation/proof that uses it: surface assertion
- Wrong behavior if removed: search path missing

- Item: 1301
- Why it exists: notification row proves notification candidates
- Simulation/proof that uses it: surface assertion
- Wrong behavior if removed: notification path missing

- Item: 701
- Why it exists: blocked author proves shared safety
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: blocked leaks across surfaces

- Item: 1001
- Why it exists: unsafe content proves shared safety
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: unsafe leaks across surfaces

## Broken operating/ranking behavior

Broken capstone builds only a For You list, skips shared safety, and omits design layers.

## Exact wrong result from the broken version

Blocked 701 and unsafe 1001 can leak, stories/search/notification outputs are empty, and system_design misses observability and incident_playbook.

## Correct result from the solution

following_feed [101], for_you_feed [101, 501, 601, 901], stories_tray [1101], search_results [1201], notification_candidates [1301], creator_discovery ["lina", "theo"].

## Proof assertions

Every surface output, rejections, debug traces, missing explanations, experiment guardrails, replay summary, and system design layers.

## Beginner mental model

A senior feed design is not one ranker. It is a set of surfaces with shared safety, logs, experiments, replay, and incident handling.

## Senior engineering review angle

Review the system boundaries: generation, features, ranking, reranking, safety, experiments, logging, replay, observability, incidents, and explicit out-of-scope choices.

## What the learner should notice

The shared layer prevents repeated safety bugs while each surface keeps its own product job.

## Interview explanation target

Walk through the layers, then prove each surface has a small deterministic output and debug reason.
