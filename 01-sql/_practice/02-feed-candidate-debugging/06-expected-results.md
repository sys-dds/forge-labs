# Expected Results

`ada_feed_candidates` must return:

| post_id | author_handle | like_count | comment_count |
| --- | --- | ---: | ---: |
| 101 | ben | 2 | 3 |
| 102 | ben | 1 | 0 |

Excluded rows:

- `201` by Cy: Ada follows Cy, but muted Cy.
- `301` by Noor: Ada follows Noor, but blocked Noor.
- `401` by Diya: Diya is not followed by Ada.

Post `102` proves the comment count join must be optional. A direct join across likes and comments turns post `101` into six joined rows because two likes multiply by three comments.
