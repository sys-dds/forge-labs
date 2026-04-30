# Design

## What this clinic teaches

Build item-level explanations from candidate source, features, score, safety, and mixing traces.

## Product surface and operating problem

Ada's feed is being checked as an operating system, not as a pretty list. The clinic follows one fixed inventory through replay, explanation, measurement, or incident handling.

## Named users/content/events and why each exists

- Item: 101
- Why it exists: Ben followed post proves affinity explanation
- Simulation/proof that uses it: seen explanation assertion
- Wrong behavior if removed: follow reason becomes vague

- Item: 501
- Why it exists: Lina backend post proves social-topic explanation
- Simulation/proof that uses it: seen explanation assertion
- Wrong behavior if removed: topic reason disappears

- Item: 601
- Why it exists: Maya Backend Club post proves group explanation
- Simulation/proof that uses it: seen explanation assertion
- Wrong behavior if removed: group source is hidden

- Item: 901
- Why it exists: Theo exploration post proves reserved slot explanation
- Simulation/proof that uses it: seen explanation assertion
- Wrong behavior if removed: exploration looks accidental

- Item: 701
- Why it exists: Noor blocked post proves safety trace
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: blocked safety row can leak

- Item: 801
- Why it exists: Omar unsafe post proves safety trace
- Simulation/proof that uses it: rejection assertion
- Wrong behavior if removed: unsafe row can leak

## Broken operating/ranking behavior

Broken explanations say recommended for you and omit exploration reasoning.

## Exact wrong result from the broken version

Broken explanations say recommended for you and omit exploration reasoning.

## Correct result from the solution

Final feed [101, 501, 601, 901] with four specific explanations and safety rejections.

## Proof assertions

Exact explanations, final feed, rejected reasons, and trace text checks.

## Beginner mental model

Follow one item from inventory to rejection or final placement. The item ID is the breadcrumb.

## Senior engineering review angle

Ask whether the proof protects the operating invariant, the debug trace, and the user-visible failure.

## What the learner should notice

A feed answer is only trustworthy when the explanation path and the metric or incident check agree with the final IDs.

## Interview explanation target

Explain the failure, the corrected rule, and the smallest proof that would catch a regression.
