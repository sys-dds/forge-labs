# Explain In Interview

## Direct answer
Use the `sellers, orders` tables to answer: For each seller, calculate completed, cancelled, disputed, refunded, and fulfilment rate.

## Dataset walkthrough
The base dataset includes 103 has zero completed orders; 102 has dispute and refund; pending rows stay in denominator. These rows exist because they expose the mistake in the broken attempt.

## Query reasoning
The solution first chooses the right row set, then computes the requested metric or ranking, then orders the final result deterministically. It does not name final answer IDs.

## Common mistake
It filters to completed orders before aggregating, so cancellation, dispute, pending, and zero-completed sellers disappear.

## Senior trade-off
Prefer a query that makes the row grain visible over a shorter query that hides which rows survived.

## Follow-up answer
Ask for rates excluding pending orders and discuss the denominator change.
