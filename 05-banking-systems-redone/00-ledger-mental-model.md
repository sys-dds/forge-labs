# Ledger Mental Model

The ledger is the source of truth for posted money movement. A balance is a derived view or snapshot; it is useful, but it must be explainable from entries or from a controlled snapshot plus later entries.

A balanced ledger transaction has debit total equal to credit total in the same currency. The useful question is not only "what is the balance?" but "which source rows prove the balance?"

Available balance is a product read model. It starts with posted balance, then subtracts active holds or reservations. Actual balance and available balance can differ without either being wrong.

Idempotency is a source table, not a comment. A retry with the same key and fingerprint should return the same transfer outcome. A same key with a different fingerprint is a conflict, not a second movement.

Lifecycle events keep history queryable. Pending authorization, posting, failure, and reversal should be explainable after the current state changes.
