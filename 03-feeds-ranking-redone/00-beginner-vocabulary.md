# Beginner Vocabulary

## Inventory

Plain-English meaning: every item the feed could consider before filters or ranking.

Tiny example from clinic 21: inventory contains 101, 501, 601, 701, 801, and 901.

Common beginner mistake: starting from the final feed and forgetting rejected rows.

How to debug it: print inventory IDs, then mark each item kept or rejected.

What a senior engineer asks next: which source failed to contribute candidates?

## Eligibility

Plain-English meaning: hard rules that decide whether an item is allowed at all.

Tiny example from clinic 21: 701 is rejected because the author is blocked and 801 is rejected because content is unsafe.

Common beginner mistake: downranking a row that should be removed.

How to debug it: check rejection reasons before scores.

What a senior engineer asks next: is this enforced consistently across every surface?

## Score

Plain-English meaning: a number used to order eligible candidates.

Tiny example from clinic 23: 401 is eligible but below the score cutoff.

Common beginner mistake: using score to explain retrieval, block, freshness, or seen-state failures.

How to debug it: ask whether the item reached scoring at all.

What a senior engineer asks next: which score component changed since the last replay?

## Diversity

Plain-English meaning: a rule that prevents one author, topic, or source from crowding out everything else.

Tiny example from clinic 23: 501 is removed by the diversity cap after 101 already represents Ben.

Common beginner mistake: sorting by score and accepting repeated authors.

How to debug it: count authors in the selected feed.

What a senior engineer asks next: does diversity protect creators, users, or both?

## Exploration

Plain-English meaning: reserved space for useful uncertainty instead of only familiar content.

Tiny example from clinic 21: 901 remains in the feed even with a lower score because exploration is reserved.

Common beginner mistake: dropping exploration when optimizing short-term engagement.

How to debug it: check whether the mixer reserved an exploration slot.

What a senior engineer asks next: how do we measure exploration quality without letting it become spam?

## Debug trace

Plain-English meaning: row-level evidence explaining why an item appeared or disappeared.

Tiny example from clinic 22: 901 says the exploration slot was reserved.

Common beginner mistake: returning a vague explanation that cannot be checked.

How to debug it: require source, feature, score, safety, and mixing evidence.

What a senior engineer asks next: can support and on-call read the same trace?

## Offline replay

Plain-English meaning: rerunning a fixed dataset to catch regressions before launch.

Tiny example from clinic 21: actual_feed must match golden_feed [101, 501, 601, 901].

Common beginner mistake: checking output length instead of exact IDs and rejected reasons.

How to debug it: compare missing and unexpected item IDs.

What a senior engineer asks next: which replays block merges?

## Guardrail metric

Plain-English meaning: a metric that can block launch even when the primary metric improves.

Tiny example from clinic 26: CTR improves but hide/report rate, creator diversity, and retention fail.

Common beginner mistake: launching on CTR alone.

How to debug it: list every failed guardrail by name.

What a senior engineer asks next: which guardrail protects against silent user harm?
