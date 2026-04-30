# Design

## What this clinic teaches

Ranking inputs should expose inspectable feature columns: engagement, source affinity, recency, raw score, stable order, and repeated-author grouping.

## Named rows and why each exists

- Row: Ben post 101.
  Why it exists: proves comments can outrank raw likes when weighted.
  Query/proof that uses it: exact score and rank 1.
  Wrong behavior if removed: comment weighting is not proven.
- Row: Ben post 102.
  Why it exists: proves raw likes alone is not the ranking formula.
  Query/proof that uses it: exact score and repeated-author group.
  Wrong behavior if removed: likes-only broken query is weaker.
- Row: Maya post 301.
  Why it exists: proves shared-group affinity bonus.
  Query/proof that uses it: exact score and rank 3.
  Wrong behavior if removed: group source scoring is untested.
- Row: Lina post 601.
  Why it exists: proves liked-by-following has lower affinity despite engagement.
  Query/proof that uses it: exact score and rank 4.
  Wrong behavior if removed: affinity trade-off is untested.
- Row: Lina post 602.
  Why it exists: proves reposted-by-following scoring and repeated-author detection.
  Query/proof that uses it: exact score and diversity group.
  Wrong behavior if removed: repeated Lina author is not detected.
- Row: Ada replied to Ben before.
  Why it exists: explains why followed-author candidates carry high affinity in this clinic.
  Query/proof that uses it: interview and debugging notes.
  Wrong behavior if removed: Ben affinity has less row-level support.

## Broken query bug

The broken query ranks by likes only, hides feature columns, ignores comments, ignores source affinity, omits diversity group, and has no complete stable tie-breaker.

## Exact wrong result from the broken query

Ben 102 ranks first by 5 likes even though Ben 101 has the highest documented raw_score of 31.

## Correct result from the solution

Ranking order is Ben 101, Ben 102, Maya 301, Lina 601, Lina 602 with exact feature scores.

## Proof assertions

The proof checks every score, rank order, feature columns, comment weighting, Ben/Maya/Lina affinity, stable order, and repeated-author diversity group.

## What the learner should notice

Ranking input rows are still SQL data: they should be inspectable before any later ranking service exists.

## Interview explanation target

Explain eligibility before ranking, feature columns, simple scoring, explainability, and when SQL scoring is enough versus a later ranking path.

