# Retrieval Debugging Playbook

## Missing candidate

Plain-English meaning: an item that should be considered but did not reach ranking.

Tiny example from clinic 39: 301 is missing because the index is not fresh, and 801 is missing because the ANN bucket was not probed.

Common beginner mistake: calling every missing item low_score.

How to debug it: classify the first retrieval-stage failure.

What a senior engineer asks next: can this reason be joined to the ranking handoff logs?

## Retrieval debug trace

Plain-English meaning: row-level evidence saying which source found an item or why it was missed.

Tiny example from clinic 31: 701 is marked no_retrieval_source before ranking.

Common beginner mistake: returning IDs without source labels.

How to debug it: require a trace row for kept, rejected, and missed IDs.

What a senior engineer asks next: is the trace sampled in production replay?

## Retrieval eligibility

Plain-English meaning: exclusions that happen before ranking, such as blocked or unsafe content.

Tiny example from clinic 40: 701 is blocked_author and 801 is unsafe_content.

Common beginner mistake: letting ranking downrank content that should never enter retrieval output.

How to debug it: inspect rejected_items before scoring or blending.

What a senior engineer asks next: is eligibility shared across every source?

## Index freshness

Plain-English meaning: whether the retrieval index has the latest item state.

Tiny example from clinic 39: 301 is missing because it is not indexed yet.

Common beginner mistake: debugging ranking while the index is stale.

How to debug it: print index version, item updated time, and freshness status.

What a senior engineer asks next: what freshness lag pages on-call?

## Embedding drift

Plain-English meaning: user and item vectors stop matching because versions or training windows changed.

Tiny example from clinic 39: 401 is missing because the embedding version mismatched.

Common beginner mistake: accepting lower recall without checking vector versions.

How to debug it: print user vector version and item vector version with the miss reason.

What a senior engineer asks next: can replay compare old and new embeddings?

## Source blending

Plain-English meaning: merging candidates from multiple sources with quotas and reasons.

Tiny example from clinic 36: 601 keeps lexical + semantic as its source reason.

Common beginner mistake: overwriting the earlier source when a second source finds the same item.

How to debug it: keep source arrays until the ranking handoff.

What a senior engineer asks next: which source should get quota when traffic spikes?
