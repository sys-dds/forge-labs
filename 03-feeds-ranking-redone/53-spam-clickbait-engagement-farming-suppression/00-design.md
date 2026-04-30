# Design

## What this clinic teaches

Spam clickbait engagement farming suppression teaches how safety evidence changes candidate treatment before, during, and after ranking.

## Safety/integrity problem and user impact

Ada's feed can be harmed when policy labels, evidence rows, trust signals, reports, appeals, or incident checks are hidden from the ranking path.

## Named users/content/reports/policies and why each exists

For every important item:

- Item: Ada
- Why it exists: viewer whose feed receives safety-aware treatment.
- Simulation/proof that uses it: proof checks the final safety-aware output.
- Wrong behavior if removed: the clinic becomes a global moderation list.

- Item: post_501, post_101, post_601, post_201, post_301
- Why it exists: expected safe output or decision surface for spam clickbait engagement farming suppression.
- Simulation/proof that uses it: proof asserts exact output plus treatment rows.
- Wrong behavior if removed: ranking can pass without safety semantics.

- Item: rejected/downranked/informed/review/audit rows
- Why it exists: proves treatment is not one generic score penalty.
- Simulation/proof that uses it: proof checks exact reason and stage fields.
- Wrong behavior if removed: unsafe shortcuts can hide behind final IDs.

## Broken safety/ranking behavior

The broken version uses the wrong safety ordering or collapses policy treatment into a single score.

## Exact wrong result from the broken version

`raw engagement ranks bait first`

## Correct result from the solution

`post_501, post_101, post_601, post_201, post_301`

## Proof assertions

The proof asserts exact safe/final feed or decisions, exact treatment rows, semantic evidence rows, audit rows where relevant, and `safety_debug_trace` entries with actual IDs.

## Beginner mental model

Safety is not just ranking lower. Some rows are removed, some reduced, some labelled, some reviewed, and some allowed with audit evidence.

## Senior engineering review angle

Review whether every safety decision has evidence, stage ownership, treatment, and later auditability.

## What the learner should notice

The same content score can produce different outcomes when policy label, trust score, report reliability, appeal state, or context changes.

## Interview explanation target

Explain spam clickbait engagement farming suppression with the row that proves the risk and the treatment that ranking receives.
