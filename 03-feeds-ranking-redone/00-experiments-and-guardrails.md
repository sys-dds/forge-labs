# Experiments And Guardrails

## Primary metric

Plain-English meaning: the metric the experiment is trying to improve.

Tiny example from clinic 26: treatment CTR rises from 10% to 14%.

Common beginner mistake: launching as soon as the primary metric improves.

How to debug it: compute the delta, then read the guardrail failures before making a decision.

What a senior engineer asks next: is the primary metric aligned with long-term user value?

## Safety guardrail

Plain-English meaning: a metric that blocks launch when user harm increases.

Tiny example from clinic 26: hide/report rate rises from 1% to 5%, so the treatment fails.

Common beginner mistake: calling the launch successful because clicks increased.

How to debug it: list each failed guardrail by name in the launch decision.

What a senior engineer asks next: should this guardrail page someone or only block rollout?

## Diversity and retention guardrails

Plain-English meaning: checks that the feed is not narrowing creators or hurting return behavior.

Tiny example from clinic 26: creator diversity drops from 5 to 2 and retention drops from 40% to 37%.

Common beginner mistake: hiding these under one vague quality score.

How to debug it: keep creator diversity and retention as separate failures.

What a senior engineer asks next: which segment regressed first?
