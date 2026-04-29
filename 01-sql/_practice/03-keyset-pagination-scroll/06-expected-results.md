# Expected Results

Before the new insert, page one is:

| id | created_at |
| ---: | --- |
| 107 | 2026-04-29 10:06:00 |
| 106 | 2026-04-29 10:05:00 |

The cursor is `(2026-04-29 10:05:00, 106)`.

After post `108` is inserted above the cursor, keyset page two remains:

| id | created_at |
| ---: | --- |
| 105 | 2026-04-29 10:04:00 |
| 104 | 2026-04-29 10:04:00 |

The offset page two example returns `106, 105`, repeating `106` from page one because the new post shifted the row positions.

The duplicate timestamp pair proves the cursor must include `id`, not just `created_at`.
