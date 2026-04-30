# Explain In Interview

## Direct answer
Use `sellers, listings, orders, listing_impressions` to answer: Find sellers eligible for promotion this week: active seller, at least 3 active listings, at least 5 completed orders, cancellation rate below 15%, dispute rate below 8%, average response time below 60 minutes, and at least one listing impression since 2026-01-26.

## Dataset walkthrough
The base dataset includes seller 102 has enough listings but weak fulfilment; seller 103 has good fulfilment but no recent impressions; seller 104 has recent impressions but too few completed orders; seller 105 is inactive; seller 101 is eligible. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution uses CTEs for active listings, order metrics, recent impressions, and final eligibility. Each CTE has one grain, then the final SELECT applies thresholds.

## Common mistake
It joins recent impressions too early and counts orders after row multiplication, so thresholds can be crossed by duplicated evidence.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for ineligible sellers with the first failed rule as the reason.
