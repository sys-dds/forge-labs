# Interview Explanation

## Direct answer

I would model follows as directed edges and write separate queries for following, followers, mutuals, and safe second-degree suggestions.

## Dataset walkthrough

Ada follows Ben, Cy, and Maya. Ben follows Ada, so Ben is mutual. Ben, Cy, and Maya all point to Diya, so Diya has three raw suggestion paths. Cy points to Noor, but Ada blocked Noor. Omar follows Ada, but Ada does not follow Omar. Theo is disconnected.

## Query reasoning

Following traverses outgoing edges from Ada. Followers traverse incoming edges to Ada. Mutuals require both directions. Suggestions traverse Ada's outgoing edge to a first hop, then that user's outgoing edge to a candidate, then remove Ada, already-followed users, and blocked users.

## Common mistake

The common mistake is treating second-degree reachability as eligibility. Noor is reachable, but the block row removes Noor.

## Senior trade-off

`DISTINCT` is fine for collapsing duplicate paths to Diya, but it is not a safety rule. Safety needs explicit exclusions.

## Follow-up answer

If suggestion logic grows, I would keep edge direction and exclusions readable first, then consider materialized candidate sets or graph summaries after checking actual query plans.

