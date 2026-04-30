# Pattern

## What this clinic practices
LAG-based event stream debugging.

## Actual tables
`order_status_events` stores the event order, timestamp, and status for each order.

## Actual rows that trap the learner
Order 102 completes before paid, 103 ships after cancelled, 104 duplicates completed, 105 refunds before completed, and the variant adds a timestamp-backwards event.

## Why the broken query fails
The broken query checks final status only, so it misses impossible intermediate transitions.

## Correct query shape
Use LAG over event_id per order to compare previous status/time to current status/time and emit violation reasons.

## Interview wording
Name the relational rule first, then name the guardrail that keeps the answer stable across the variant seed.
