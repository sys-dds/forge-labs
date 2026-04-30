# Design

## What this clinic teaches

Out-of-Network Recommendations teaches out-of-network retrieval, source quotas, cold start, and safety before ranking.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben is the in-network baseline and is not part of out-of-network page.
- Simulation/proof that uses it: not_in_final.
- Wrong behavior if removed: out-of-network retrieval could silently become a normal following feed.

- Item: Lina post 501
- Why it exists: Lina backend post matches Ada backend interest.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: similar-topic retrieval would be untested.

- Item: Lina post 502
- Why it exists: Lina Java post proves the first-page author cap.
- Simulation/proof that uses it: author_cap.
- Wrong behavior if removed: the page could overfill with Lina.

- Item: Maya post 601
- Why it exists: Maya OLED movie post matches Ada OLED movies interest.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: non-backend interest retrieval would disappear.

- Item: Noor post 801
- Why it exists: Noor is blocked/unsafe and proves safety happens before retrieval output.
- Simulation/proof that uses it: blocked_excluded.
- Wrong behavior if removed: blocked content could be recommended as trending.

- Item: Theo post 901
- Why it exists: Theo is exploration fallback and proves cold-start inclusion.
- Simulation/proof that uses it: exploration_included.
- Wrong behavior if removed: the page would have no fallback when known sources are thin.

## Broken ranking behavior

broken output uses trending only, returns Noor 801, repeats Lina 501 and 502, and omits cold-start Theo 901.

## Exact wrong result from the broken version

broken output uses trending only, returns Noor 801, repeats Lina 501 and 502, and omits cold-start Theo 901.

## Correct result from the solution

The corrected simulation returns [501,601,701,901].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected out-of-network candidates [501,601,701,901]; broken retriever used only trending, included blocked Noor 801, repeated Lina, or omitted exploration Theo 901.

## What the learner should notice

Lina post 501 survives for a specific reason, Maya post 601 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain out-of-network recommendations using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
