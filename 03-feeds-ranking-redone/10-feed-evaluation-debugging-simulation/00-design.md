# Design

## What this clinic teaches

Feed Evaluation Debugging Simulation teaches end-to-end feed debugging, rejected item reasons, score components, diversity adjustments, and offline replay.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben valid in-network item proves the bug fix keeps relevant content.
- Simulation/proof that uses it: final_feed_exact.
- Wrong behavior if removed: debugging might remove all Ben content.

- Item: Ben post 102
- Why it exists: Ben second post proves repeated-author reduction.
- Simulation/proof that uses it: diversity_adjustments.
- Wrong behavior if removed: Ben repetition would not be diagnosed.

- Item: Ben post 103
- Why it exists: Ben third post proves top-three repetition was the reported bug.
- Simulation/proof that uses it: diversity_adjustments.
- Wrong behavior if removed: the replay would miss the reported repetition.

- Item: Lina post 501
- Why it exists: Lina similar-topic item proves out-of-network recommendation survives.
- Simulation/proof that uses it: final_feed_exact.
- Wrong behavior if removed: the fix would collapse to in-network only.

- Item: Maya post 601
- Why it exists: Maya group item proves group source survives.
- Simulation/proof that uses it: final_feed_exact.
- Wrong behavior if removed: group candidates would disappear.

- Item: Noor post 701
- Why it exists: Noor blocked content proves rejected_items has block reason.
- Simulation/proof that uses it: rejected_items_exact.
- Wrong behavior if removed: blocked content could appear without trace.

- Item: New creator 901
- Why it exists: New creator proves exploration is restored.
- Simulation/proof that uses it: exploration_included.
- Wrong behavior if removed: the replay would not catch missing exploration.

## Broken ranking behavior

broken output is [701,101,102,103], leaking blocked Noor, repeating Ben, and omitting exploration.

## Exact wrong result from the broken version

broken output is [701,101,102,103], leaking blocked Noor, repeating Ben, and omitting exploration.

## Correct result from the solution

The corrected simulation returns [101,501,601,901].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected final feed [101,501,601,901]; broken replay returned blocked Noor 701, repeated Ben 101/102/103, or omitted exploration 901.

## What the learner should notice

Ben post 102 survives for a specific reason, Lina post 501 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain feed evaluation and debugging using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
