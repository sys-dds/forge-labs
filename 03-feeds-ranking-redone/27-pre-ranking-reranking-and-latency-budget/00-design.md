# Design

## What this clinic teaches

Keep unsafe content out early, heavy-rank only a shortlist, rerank for diversity and freshness, and stay under 100ms.

## Product surface and operating problem

Ada's feed needs a replayable operating decision with fixed rows and visible evidence.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: followed item proves shortlist path
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: in-network anchor lost

- Item: 401
- Why it exists: fresh diverse item proves reranker
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: freshness ignored

- Item: 501
- Why it exists: topic item proves heavy ranker
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: topic candidate lost

- Item: 801
- Why it exists: exploration item proves mix slot
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: exploration lost

- Item: 301
- Why it exists: unsafe item proves prefilter
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: unsafe row heavy-ranked

- Item: latency
- Why it exists: 100ms budget proves staged work
- Simulation/proof that uses it: latency assertion
- Wrong behavior if removed: pipeline too slow

- Item: shortlist
- Why it exists: shortlist proves not every candidate heavy-ranked
- Simulation/proof that uses it: heavy-ranked assertion
- Wrong behavior if removed: expensive ranker overused

## Broken operating/ranking behavior

Broken pipeline heavy-ranks every candidate and lets unsafe 301 through.

## Exact wrong result from the broken version

Broken pipeline heavy-ranks every candidate and lets unsafe 301 through.

## Correct result from the solution

Final feed [101, 401, 501, 801], 301 rejected early, total latency <= 100ms, shortlist only heavy-ranked.

## Proof assertions

Exact output, debug trace, and clinic-specific rejected, missing, regressed, metric, or guardrail evidence.

## Beginner mental model

A feed decision is a chain of small gates. The ID tells you which gate changed the result.

## Senior engineering review angle

Ask what would block launch, page an owner, or explain the incident to a product lead.

## What the learner should notice

The operating evidence is part of the feature, not paperwork after the feed is built.

## Interview explanation target

Describe the rule, the user harm, the proof, and the next production guardrail.
