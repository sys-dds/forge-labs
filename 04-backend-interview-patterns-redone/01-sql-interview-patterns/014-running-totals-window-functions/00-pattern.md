# Pattern

## What this clinic teaches
Cumulative balances with SUM over ordered partitions.

## Actual tables
`ledger_entries`.

## Actual rows that create the trap
wallet 101 has a voided transaction that must not count; wallet 101 goes negative; wallet 102 has same-timestamp entries needing ledger_entry_id tie-break; multiple wallets appear.

## Why the broken query fails
It aggregates one total per wallet and loses the per-entry running balance.

## Correct query steps
1. Establish the row grain before filtering or ranking.
2. Keep disqualifying or missing evidence visible long enough to score it.
3. Compute the metric from data values rather than final IDs.
4. Return columns in the expected order with deterministic ordering.

## Interview phrasing
Say which table provides the entity, which table provides the evidence, which rows are traps, and why the SQL shape proves the business rule.
