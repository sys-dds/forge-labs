# Explain In Interview

## Direct answer
I would solve this with LAG-based event stream debugging, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Order 102 completes before paid, 103 ships after cancelled, 104 duplicates completed, 105 refunds before completed, and the variant adds a timestamp-backwards event.

## Query reasoning
Use LAG over event_id per order to compare previous status/time to current status/time and emit violation reasons.

## Common mistake
The broken query checks final status only, so it misses impossible intermediate transitions.

## Follow-up answer
A follow-up may ask you to validate allowed transitions from a reference table.
