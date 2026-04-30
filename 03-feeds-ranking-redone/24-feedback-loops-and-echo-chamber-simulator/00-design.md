# Design

## What this clinic teaches

Use feedback to boost real interests, penalize clickbait, preserve a secondary interest, and reserve exploration.

## Product surface and operating problem

Ada's feed needs an operating proof: fixed rows, visible decisions, and output that can be replayed.

## Named users/content/events and why each exists

- Item: 104
- Why it exists: backend quality post proves moderate boost
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: backend interest collapses

- Item: 401
- Why it exists: movie completed item proves secondary interest
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: movies vanish

- Item: 402
- Why it exists: second movie item proves preservation
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: secondary interest too weak

- Item: 901
- Why it exists: exploration post proves reserve
- Simulation/proof that uses it: final feed assertion
- Wrong behavior if removed: exploration disappears

- Item: 801
- Why it exists: unsafe row proves rejection
- Simulation/proof that uses it: rejected assertion
- Wrong behavior if removed: unsafe content leaks

- Item: echo_chamber_risk
- Why it exists: risk report proves too-narrow backend exposure
- Simulation/proof that uses it: report assertion
- Wrong behavior if removed: loop risk is invisible

## Broken operating/ranking behavior

Broken output over-boosts backend clickbait, drops movies, and removes exploration.

## Exact wrong result from the broken version

Broken output over-boosts backend clickbait, drops movies, and removes exploration.

## Correct result from the solution

Final feed [104, 401, 402, 901], unsafe 801 rejected, echo_chamber_risk reported.

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
