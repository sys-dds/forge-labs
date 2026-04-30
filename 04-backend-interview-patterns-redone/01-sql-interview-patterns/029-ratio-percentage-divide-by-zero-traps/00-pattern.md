# Pattern

## What this clinic practices
safe ratio calculations with NULLIF and numeric precision.

## Actual tables
`variant_events` stores impression/click/hide/report counts per experiment variant.

## Actual rows that trap the learner
Variant B has high reports, C has zero impressions, and E has counts where integer division would flatten the rate to zero.

## Why the broken query fails
The broken query divides integers directly and does not guard zero impressions.

## Correct query shape
Cast to numeric, divide by NULLIF(impressions,0), round rates, and derive the quality decision from thresholds.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
