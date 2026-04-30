# Design

## What this clinic teaches

Candidate Mixing and Deduplication teaches deduplication, source priority, source quotas, and preserved explanations.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben is in-network and should lead the mixed page.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: the in-network quota would be untested.

- Item: Ben post 102
- Why it exists: Ben second in-network item proves source quota limits extra in-network rows.
- Simulation/proof that uses it: source_quota_respected.
- Wrong behavior if removed: in-network could crowd out other sources.

- Item: Lina post 501
- Why it exists: Lina appears in three pools and proves dedupe with all reasons.
- Simulation/proof that uses it: dedupe_and_reasons.
- Wrong behavior if removed: the mixer could show duplicate 501 rows.

- Item: Maya post 601
- Why it exists: Maya similar-topic row proves topic retrieval survives mixing.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: similar-topic source could be swallowed by trending.

- Item: Omar post 701
- Why it exists: Omar trending row proves a bounded trending slot exists.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: trending quota would not be visible.

- Item: Theo post 901
- Why it exists: Theo exploration row proves low-score exploration can remain.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: the page would lack exploration.

## Broken ranking behavior

broken output repeats Lina 501 three times, loses reasons, and lets trending dominate the page.

## Exact wrong result from the broken version

broken output repeats Lina 501 three times, loses reasons, and lets trending dominate the page.

## Correct result from the solution

The corrected simulation returns [101,501,601,701,901].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected mixed page [101,501,601,701,901] with one Lina 501 carrying social_proof, similar_topic, trending; broken mixer duplicated 501 or lost reasons.

## What the learner should notice

Ben post 102 survives for a specific reason, Maya post 601 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain candidate mixing and deduplication using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
