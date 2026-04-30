# Debugging Feed Output

When Ada asks why she saw something, start with `debug_trace`. It should name the item and the reason it survived.

When Ada asks why she did not see something, start with `rejected_items`, then check candidate rows and score rows.

Practical checklist:

1. Confirm the product surface.
2. Check inventory.
3. Check eligibility and rejected reasons.
4. Check candidate source labels.
5. Check feature and score rows.
6. Check final output order.
7. Replay the broken simulation to see the exact product bug.
