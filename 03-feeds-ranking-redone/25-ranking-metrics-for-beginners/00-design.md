# Design

## What this clinic teaches

Compare CTR with completion, skips, hides, dwell, diversity, and repeat-author pressure.

## Product surface and operating problem

Ada's feed needs an operating proof: fixed rows, visible decisions, and output that can be replayed.

## Named users/content/events and why each exists

- Item: Variant A
- Why it exists: higher CTR but worse quality guardrails
- Simulation/proof that uses it: winner assertion
- Wrong behavior if removed: click-only launch wins

- Item: Variant B
- Why it exists: lower CTR but better completion and guardrails
- Simulation/proof that uses it: winner assertion
- Wrong behavior if removed: quality winner is missed

- Item: clicks
- Why it exists: CTR calculation proves primary metric
- Simulation/proof that uses it: metric assertion
- Wrong behavior if removed: CTR cannot be discussed

- Item: completed
- Why it exists: completion rate proves depth
- Simulation/proof that uses it: metric assertion
- Wrong behavior if removed: completion is ignored

- Item: hides_reports
- Why it exists: hide rate proves safety pressure
- Simulation/proof that uses it: metric assertion
- Wrong behavior if removed: safety pressure is hidden

- Item: distinct_authors
- Why it exists: diversity proves author breadth
- Simulation/proof that uses it: metric assertion
- Wrong behavior if removed: author concentration is hidden

## Broken operating/ranking behavior

Broken comparison chooses Variant A on CTR alone.

## Exact wrong result from the broken version

Broken comparison chooses Variant A on CTR alone.

## Correct result from the solution

Winner Variant B because quality and guardrails beat CTR-only uplift.

## Proof assertions

The proof checks exact output, debug trace, and the clinic-specific rejected, missing, regressed, metric, or guardrail rows.

## Beginner mental model

Each row is a test fixture with a job. If a row disappears, one product lesson disappears with it.

## Senior engineering review angle

Review whether telemetry would explain this decision during replay, launch review, or incident response.

## What the learner should notice

A feed system is measured by decisions and explanations, not only by a sorted list.

## Interview explanation target

Explain the product failure, the row that proves it, and the smallest corrected algorithm.
