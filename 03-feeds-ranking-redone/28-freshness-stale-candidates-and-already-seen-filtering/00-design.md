# Design

## What this clinic teaches

Filter already-seen, stale, blocked, and duplicate rows while allowing an evergreen exception.

## Product surface and operating problem

Ada's feed is checked with deterministic rows, visible rejection reasons, and exact surface outputs.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: fresh valid post
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: fresh anchor lost

- Item: 102
- Why it exists: already-seen copy
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: repeat appears

- Item: 201
- Why it exists: stale high-score post
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: stale high-score leaks

- Item: 301
- Why it exists: fresh group post
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: group row lost

- Item: 401
- Why it exists: fresh topic post
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: topic row lost

- Item: 501
- Why it exists: evergreen exception
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: evergreen content filtered wrongly

- Item: 601
- Why it exists: blocked author
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: blocked row leaks

- Item: 701
- Why it exists: duplicate content
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: duplicate row leaks

## Broken operating/ranking behavior

Broken feed includes stale high-score 201 and already-seen 102.

## Exact wrong result from the broken version

Broken feed includes stale high-score 201 and already-seen 102.

## Correct result from the solution

Final feed [101, 301, 401, 501] with specific rejection reasons.

## Proof assertions

Exact outputs, debug trace, and clinic-specific rejected, missing, regressed, metric, or incident evidence.

## Beginner mental model

Follow one ID from inventory to its final surface or rejection reason.

## Senior engineering review angle

Ask which invariant blocks product harm and where it appears in replay or incidents.

## What the learner should notice

The answer is the output plus the evidence that explains it.

## Interview explanation target

State the failure, the rows that reveal it, the corrected rule, and the proof.
