# Explain In Interview

## Direct answer
Use `ledger_entries` to answer: For posted transactions only, return each wallet ledger entry with running balance after that entry.

## Dataset walkthrough
The base dataset includes wallet 101 has a voided transaction that must not count; wallet 101 goes negative; wallet 102 has same-timestamp entries needing ledger_entry_id tie-break; multiple wallets appear. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution filters posted rows, orders within each wallet by posted_at and ledger_entry_id, then uses SUM amount over the partition.

## Common mistake
It aggregates one total per wallet and loses the per-entry running balance.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask how to include voided rows as visible zero-impact audit rows.
