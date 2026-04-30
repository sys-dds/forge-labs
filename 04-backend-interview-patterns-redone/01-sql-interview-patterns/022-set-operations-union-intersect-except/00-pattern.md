# Pattern

## What this clinic practices
UNION, INTERSECT, and EXCEPT set reasoning.

## Actual tables
`creators`, `posts`, `payout_onboarding`, `policy_violations`, and `fraud_investigations` model monetisation eligibility.

## Actual rows that trap the learner
Ana has safe posts and payout, Ben lacks payout, Cy has a policy violation, Diya is in fraud review, Eli has unsafe posts, and Faye is inactive.

## Why the broken query fails
The broken query uses OR predicates, so one good condition can mask a disqualifier.

## Correct query shape
Build eligible sets separately, intersect active/safe/payout creators, then except policy and fraud sets.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
