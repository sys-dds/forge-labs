# Common Banking Modeling Traps

## One mutable balance only

Wrong because it cannot explain pending holds, posted movements, or replayable audit. The clinics keep source rows such as `ledger_entries` and `account_holds` visible.

## Transfer as one from-to row only

Wrong because retries can double-post and there is no debit/credit proof. BANK-R2-003 links `transfer_requests`, `idempotency_keys`, attempts, and ledger entries.

## Ignoring pending, failed, and reversed lifecycle

Wrong because posted balance and pending exposure answer different questions. BANK-R2-004 derives current state from `transaction_events` and keeps `reversals` linked to originals.

## Counting only credits or only debits

Wrong because a ledger transaction can look active while unbalanced. BANK-R2-002 explicitly detects transaction `9002` as unbalanced.

## Trusting a retry payload without fingerprinting

Wrong because `idem-rent-001` can be replayed with a different amount. BANK-R2-003 stores the fingerprint and returns conflict rows.
