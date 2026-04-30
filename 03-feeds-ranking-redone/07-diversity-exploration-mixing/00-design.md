# Design

## What this clinic teaches

Diversity Exploration Mixing teaches author caps, topic caps, exploration slots, fresh item inclusion, and safety filtering after initial ranking.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben top backend item proves relevance is preserved.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: diversity might discard the strongest valid item.

- Item: Ben post 102
- Why it exists: Ben second backend item proves author cap allows two, not zero.
- Simulation/proof that uses it: author_cap.
- Wrong behavior if removed: author cap would be too aggressive or missing.

- Item: Ben post 103
- Why it exists: Ben third backend item proves repeated-author suppression.
- Simulation/proof that uses it: author_cap.
- Wrong behavior if removed: Ben could fill the page.

- Item: Maya post 601
- Why it exists: Maya movies item proves topic diversity insertion.
- Simulation/proof that uses it: topic_cap.
- Wrong behavior if removed: backend topic could fill every slot.

- Item: Diya post 701
- Why it exists: Diya cooking item proves another non-backend topic survives.
- Simulation/proof that uses it: topic_cap.
- Wrong behavior if removed: only one alternate topic would be tested.

- Item: New creator 901
- Why it exists: New creator proves exploration slot.
- Simulation/proof that uses it: exploration_included.
- Wrong behavior if removed: exploration could be omitted.

- Item: Unsafe item 1001
- Why it exists: Unsafe high score proves safety beats score.
- Simulation/proof that uses it: unsafe_excluded.
- Wrong behavior if removed: unsafe content could top the page.

## Broken ranking behavior

broken output returns [1001,101,102,103,104], showing unsafe content, four Ben posts, no exploration, and too many backend rows.

## Exact wrong result from the broken version

broken output returns [1001,101,102,103,104], showing unsafe content, four Ben posts, no exploration, and too many backend rows.

## Correct result from the solution

The corrected simulation returns [101,102,601,701,901].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected diverse feed [101,102,601,701,901]; broken ranker returned unsafe 1001, repeated Ben four times, overfilled backend, or omitted exploration 901.

## What the learner should notice

Ben post 102 survives for a specific reason, Maya post 601 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain diversity exploration mixing using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
