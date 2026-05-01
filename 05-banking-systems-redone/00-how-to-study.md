# How To Study Banking Systems Redone

1. Read the interview prompt and name the invariant before looking at SQL.
2. Inspect `02-schema.sql` and identify source-of-truth rows versus read/query rows.
3. Read `03-seed.sql` and write down the trap rows: holds, unbalanced entries, duplicate attempts, failed events, reversals.
4. Run `./scripts/bank-r2-test-one.sh <clinic>` and confirm the base proof, variant proof, and broken-query proof all run.
5. Change one trap row locally and predict which contract row should fail.
6. Move on when you can explain the tables, the write path, the read path, and the broken shortcut without reading the docs.

Repeat a clinic when your explanation collapses to a single mutable balance, one transfer row, one status column, or an opaque score-like total without lineage.
