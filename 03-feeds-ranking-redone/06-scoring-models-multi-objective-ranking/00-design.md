# Design

## What this clinic teaches

Scoring Models and Multi-Objective Ranking teaches readable multi-objective scoring as a stand-in for prediction models.

## Named users/content and why each exists

- Item: Ben post 101
- Why it exists: Ben has high comment probability and relationship value.
- Simulation/proof that uses it: score_components_exact.
- Wrong behavior if removed: comment and relationship objectives would be invisible.

- Item: Lina video 501
- Why it exists: Lina has high watch completion and wins the final score.
- Simulation/proof that uses it: final_order_exact.
- Wrong behavior if removed: watch objective would not be tested.

- Item: Maya post 601
- Why it exists: Maya has high share probability.
- Simulation/proof that uses it: score_components_exact.
- Wrong behavior if removed: share objective could be ignored.

- Item: Omar clickbait 701
- Why it exists: Omar has high like probability but high hide risk.
- Simulation/proof that uses it: hide_penalty_applied.
- Wrong behavior if removed: negative risk could be mistaken for success.

- Item: New creator 901
- Why it exists: New creator proves exploration bonus can lift low predictions.
- Simulation/proof that uses it: exploration_bonus_applied.
- Wrong behavior if removed: exploration objective would vanish.

## Broken ranking behavior

broken output ranks Omar 701 first by like probability despite high hide/report risk and hides score components.

## Exact wrong result from the broken version

broken output ranks Omar 701 first by like probability despite high hide/report risk and hides score components.

## Correct result from the solution

The corrected simulation returns [501,101,601,901,701].

## Proof assertions

The proof checks expected IDs, exact ordering, exclusion behavior, reason labels or trace fields, and clinic-specific constraints from the dataset. Failure messages name expected multi-objective order [501,101,601,901,701]; broken like-only ranker put Omar 701 first and ignored hide risk, comments, shares, watch completion, relationship, and exploration.

## What the learner should notice

Lina video 501 survives for a specific reason, Omar clickbait 701 proves exclusion or constraint handling, and the final output is deterministic so a changed rule creates a visible regression.

## Interview explanation target

Explain multi-objective ranking using Ada and the exact items in this folder, then describe why the broken output is wrong before discussing trade-offs.
