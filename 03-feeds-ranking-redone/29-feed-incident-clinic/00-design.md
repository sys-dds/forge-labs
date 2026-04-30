# Design

## What this clinic teaches

Reproduce a bad feed, diagnose disabled filters, apply mitigations, and run regression checks.

## Product surface and operating problem

Ada's feed is checked with deterministic rows, visible rejection reasons, and exact surface outputs.

## Named users/content/events and why each exists

- Item: 701
- Why it exists: blocked item in bad feed
- Simulation/proof that uses it: root cause assertion
- Wrong behavior if removed: eligibility issue hidden

- Item: 101
- Why it exists: valid Ben item
- Simulation/proof that uses it: corrected feed assertion
- Wrong behavior if removed: good anchor absent

- Item: 102
- Why it exists: duplicate notification source
- Simulation/proof that uses it: dedupe assertion
- Wrong behavior if removed: notification spam hidden

- Item: 103
- Why it exists: same author pressure
- Simulation/proof that uses it: diversity assertion
- Wrong behavior if removed: author cap issue hidden

- Item: 801
- Why it exists: stale unsafe row
- Simulation/proof that uses it: root cause assertion
- Wrong behavior if removed: safety freshness issue hidden

- Item: 501
- Why it exists: Lina recovery item
- Simulation/proof that uses it: corrected feed assertion
- Wrong behavior if removed: recovery feed too narrow

- Item: 601
- Why it exists: Maya recovery item
- Simulation/proof that uses it: corrected feed assertion
- Wrong behavior if removed: group recovery missing

- Item: 901
- Why it exists: exploration recovery item
- Simulation/proof that uses it: corrected feed assertion
- Wrong behavior if removed: exploration remains off

## Broken operating/ranking behavior

Broken bad_feed [701, 101, 102, 103, 801].

## Exact wrong result from the broken version

Broken bad_feed [701, 101, 102, 103, 801].

## Correct result from the solution

Corrected feed [101, 501, 601, 901], root causes and mitigations all present.

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
