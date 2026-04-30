# Design

## What this clinic teaches

Stable feed pagination continues after the exact last seen row, not after a page number.

## Named rows and why each exists

- Post 107 and post 106 are page one before insert.
- Post 108 arrives later and shifts offset pagination.
- Post 106 is the cursor row.
- Post 105 and post 104 share a timestamp and require id tie-break order.
- Post 103 proves the next row after tied post 104.

## Broken query bug

The broken query uses offset page two and a created_at-only cursor, so new post 108 can duplicate 106 and timestamp ties can skip 104.

## Exact wrong result from the broken query

After 108 arrives, offset page two contains 106 again, and the created_at-only cursor after 105 misses tied post 104.

## Correct result from the solution

Page one is 107/106, keyset page two after 106 is 105/104, and cursor after 105 returns 104/103.

## Proof assertions

The proof checks page one ids, keyset page two ids, duplicate timestamp ordering, no duplicate 106, and tied-row continuation after 105.

## What the learner should notice

With descending order, rows after cursor 106 are less than `(10:04, 106)`.

## Interview explanation target

Explain cursor 106, why 108 does not affect keyset page two, and why `(created_at, id)` is stable.

