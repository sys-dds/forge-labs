# Design

## What this clinic teaches

Classify why an absent item failed at retrieval, eligibility, scoring, diversity, seen state, or freshness.

## Product surface and operating problem

Ada's feed is examined as an operating workflow with a fixed inventory and proof-visible item IDs.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: Ben valid post proves final inclusion
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: valid control disappears

- Item: 901
- Why it exists: Theo exploration post proves exploration inclusion
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: exploration loss is hidden

- Item: 201
- Why it exists: muted author row proves eligibility rejection
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: muted author becomes low score

- Item: 301
- Why it exists: blocked author row proves eligibility rejection
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: blocked author becomes low score

- Item: 401
- Why it exists: weak score row proves scoring cutoff
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: score cutoff is not tested

- Item: 501
- Why it exists: same-author row proves diversity cap
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: diversity cap disappears

- Item: 601
- Why it exists: unretrieved row proves retrieval miss
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: retrieval misses are misdiagnosed

- Item: 701
- Why it exists: seen row proves seen-state filter
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: already-seen repeats

- Item: 801
- Why it exists: stale row proves freshness filter
- Simulation/proof that uses it: missing assertion
- Wrong behavior if removed: stale content leaks

## Broken operating/ranking behavior

Broken debugger labels every missing item low_score.

## Exact wrong result from the broken version

Broken debugger labels every missing item low_score.

## Correct result from the solution

Final feed [101, 901] and stage-specific missing explanations for 201, 301, 401, 501, 601, 701, 801.

## Proof assertions

Exact final feed, all missing reasons, and debug traces for every absent item.

## Beginner mental model

Trace each item through retrieval, filtering, scoring, mixing, metrics, or incident recovery.

## Senior engineering review angle

Check that the invariant is observable and the proof would fail on the real product harm.

## What the learner should notice

The same final feed is not enough; the stage reason and trace must agree with the output.

## Interview explanation target

Name the broken rule, affected rows, corrected rule, and guardrail or trace that proves it.
