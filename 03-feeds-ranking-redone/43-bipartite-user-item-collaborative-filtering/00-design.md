# Design

## What this clinic teaches

Bipartite user-item collaborative filtering teaches user-item-user-item collaborative filtering as candidate generation before final ranking.

## Graph problem and user intent

Ada needs graph candidates from concrete nodes and edges, not a ranked feed copied from expected output.

## Named users/items/communities/edges and why each exists

For every important item:

- Item: Ada
- Why it exists: viewer whose graph neighborhood is traversed.
- Simulation/proof that uses it: proof expects Ada-derived graph candidates.
- Wrong behavior if removed: traversal becomes a global recommendation list.

- Item: post_401
- Why it exists: expected graph candidate set for user-item-user-item collaborative filtering.
- Simulation/proof that uses it: proof asserts the exact candidate pool and trace rows.
- Wrong behavior if removed: graph handoff loses the lesson candidate.

- Item: rejected or missed graph rows
- Why it exists: teaches graph-stage exclusion and miss reasons.
- Simulation/proof that uses it: proof checks exact rejected or missed reason rows.
- Wrong behavior if removed: the clinic can pass with IDs but no operational diagnosis.

## Broken graph behavior

The broken version uses the wrong graph rule, hides path details, and allows wrong candidates.

## Exact wrong result from the broken version

`[post_101, post_501, post_601]`

## Correct result from the solution

`post_401`

## Proof assertions

The proof asserts exact candidates, exact rejected or missed rows, semantic graph rows, and `graph_debug_trace` text with actual IDs.

## Beginner mental model

Graph retrieval asks which node and edge path can reach a candidate. Ranking can only score what graph retrieval hands over.

## Senior engineering review angle

Review whether every candidate has a source path, every exclusion has a stage, and every score row can be audited.

## What the learner should notice

The output changes when a path, edge type, mutual count, community strength, or safety edge changes.

## Interview explanation target

Explain user-item-user-item collaborative filtering with the exact rows in this clinic and one failure mode that would hurt the feed.
