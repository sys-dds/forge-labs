# Design

## What this clinic teaches

Reject a treatment that raises CTR while failing safety, diversity, and retention guardrails.

## Product surface and operating problem

Ada's feed needs a replayable operating decision with fixed rows and visible evidence.

## Named users/content/events and why each exists

- Item: control
- Why it exists: baseline metrics anchor deltas
- Simulation/proof that uses it: delta assertion
- Wrong behavior if removed: no baseline

- Item: treatment
- Why it exists: higher CTR but harmful guardrails
- Simulation/proof that uses it: launch assertion
- Wrong behavior if removed: CTR-only launch

- Item: hide_report_rate
- Why it exists: safety guardrail
- Simulation/proof that uses it: failure assertion
- Wrong behavior if removed: safety harm ignored

- Item: creator_diversity
- Why it exists: diversity guardrail
- Simulation/proof that uses it: failure assertion
- Wrong behavior if removed: narrow creators launch

- Item: retention
- Why it exists: retention guardrail
- Simulation/proof that uses it: failure assertion
- Wrong behavior if removed: short-term click win launches

- Item: dwell
- Why it exists: quality metric context
- Simulation/proof that uses it: debug trace
- Wrong behavior if removed: quality drop hidden

## Broken operating/ranking behavior

Broken experiment launches treatment on CTR alone.

## Exact wrong result from the broken version

Broken experiment launches treatment on CTR alone.

## Correct result from the solution

launch_decision do_not_launch with failures hide_report_rate, creator_diversity, retention.

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
