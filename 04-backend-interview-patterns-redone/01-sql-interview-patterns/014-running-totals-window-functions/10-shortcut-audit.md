# Shortcut Audit

- Likely shortcut: hard-code final IDs from `06-expected-output.csv`, force sort order with ID-specific `ORDER BY CASE`, or create expected-answer rows in SQL.
- How base proof catches it: the base CSV diff checks exact columns, order, and values for `ledger_entries`.
- How variant proof catches it: the variant dataset catches hard-coded answers because IDs and threshold outcomes change while the same solution SQL must pass.
- What mutation should fail: Remove ledger_entry_id from the window order and same-timestamp balances become nondeterministic..
- What the learner should inspect manually: wallet 101 has a voided transaction that must not count; wallet 101 goes negative; wallet 102 has same-timestamp entries needing ledger_entry_id tie-break; multiple wallets appear.
