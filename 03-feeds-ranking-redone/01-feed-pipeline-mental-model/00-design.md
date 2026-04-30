# Design

## What this clinic teaches

Feed Pipeline Mental Model teaches the full feed pipeline with eligibility before scoring and reason labels on every final item.

## Named users/content and why each exists

- Item: Ada viewer
- Why it exists: Ada drives mute, block, and feedback rules.
- Simulation/proof that uses it: eligible_ids, final_feed, feedback_log.
- Wrong behavior if removed: the proof cannot tell whose feed is being ranked.

- Item: Ben post 101
- Why it exists: Ben is followed and should survive as the first in-network item.
- Simulation/proof that uses it: final_feed_exact.
- Wrong behavior if removed: the final page would lose its valid in-network anchor.

- Item: Cy post 201
- Why it exists: Cy is muted by Ada and must be removed before scoring.
- Simulation/proof that uses it: excluded_before_scoring.
- Wrong behavior if removed: the broken ranking could treat Cy as a low-ranked item instead of removed.

- Item: Noor post 301
- Why it exists: Noor is blocked by Ada and must never reach ranking.
- Simulation/proof that uses it: excluded_before_scoring.
- Wrong behavior if removed: the proof would not catch blocked content entering the page.

- Item: Omar post 601
- Why it exists: Omar is unsafe and proves safety is not a score penalty.
- Simulation/proof that uses it: excluded_before_scoring.
- Wrong behavior if removed: unsafe content could be ranked if engagement is high.

- Item: Maya post 701
- Why it exists: Maya is an exploration item deliberately retained.
- Simulation/proof that uses it: final_feed_exact, reason_labels_present.
- Wrong behavior if removed: the page would teach only exploitation and not exploration.

## Broken ranking behavior

broken output ranks Omar 601, Noor 301, Cy 201, and Lina 501 by raw engagement before removing unsafe rows.

## Exact wrong result from the broken version

broken output ranks Omar 601, Noor 301, Cy 201, and Lina 501 by raw engagement before removing unsafe rows.

## Correct result from the solution

The corrected simulation returns [101,501,401,701].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected final feed [101,501,401,701]; broken ranker returned muted Cy 201, blocked Noor 301, or unsafe Omar 601 because it scored before eligibility.

## What the learner should notice

Ben post 101 survives for a specific reason, Noor post 301 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain feed pipeline stages using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
