# Ranking Maths For Beginners

## Rate

Plain-English meaning: a count divided by impressions so variants can be compared fairly.

Tiny example from clinic 25: Variant A CTR is 14 / 100 = 0.14, Variant B CTR is 11 / 100 = 0.11.

Common beginner mistake: stopping after CTR.

How to debug it: compute completion, skip, hide/report, diversity, repeat pressure, and dwell next to CTR.

What a senior engineer asks next: which rate can increase while the product gets worse?

## Completion rate

Plain-English meaning: the share of impressions where the user finished the item.

Tiny example from clinic 25: Variant B completion rate is 62 / 100 = 0.62.

Common beginner mistake: assuming a click means satisfaction.

How to debug it: compare clicks with completions and average dwell.

What a senior engineer asks next: does completion mean the same thing for every content type?

## Hide/report rate

Plain-English meaning: the share of impressions that caused a hide or report.

Tiny example from clinic 26: treatment hide/report rate is 5%, above the allowed guardrail.

Common beginner mistake: treating hides as a small cleanup detail.

How to debug it: make the launch decision print failed guardrails.

What a senior engineer asks next: should a safety regression stop rollout automatically?

## Repeat-author pressure

Plain-English meaning: how much the feed repeats the same creator.

Tiny example from clinic 25: Variant A repeats authors more than Variant B.

Common beginner mistake: using average score while ignoring who gets shown repeatedly.

How to debug it: count distinct authors and repeated author exposures.

What a senior engineer asks next: does this harm creator ecosystem health?

## Latency budget

Plain-English meaning: the maximum time the feed pipeline can spend before the product feels slow.

Tiny example from clinic 27: the total budget must stay at or below 100ms.

Common beginner mistake: sending every candidate to the heavy ranker.

How to debug it: print stage timings and heavy-ranked IDs.

What a senior engineer asks next: which stage should degrade first under load?
