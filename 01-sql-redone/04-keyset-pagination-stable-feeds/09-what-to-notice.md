# What To Notice

- The cursor is row 106, not page number 1.
- Post 108 is newer but irrelevant to page two after 106.
- The `(created_at, id)` pair is stable because id breaks timestamp ties.
- The proof checks both the shifted offset failure and the tied timestamp failure.

