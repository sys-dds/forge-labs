# Running totals with window functions

Scenario: Wallet ledger transactions.

The query works over `ledger_entries`. The trap rows are wallet 101 has a voided transaction that must not count; wallet 101 goes negative; wallet 102 has same-timestamp entries needing ledger_entry_id tie-break; multiple wallets appear. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
