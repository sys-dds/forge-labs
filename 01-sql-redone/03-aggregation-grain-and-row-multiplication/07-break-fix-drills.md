# Break Fix Drills

1. Replace the comment summary with a raw `JOIN comments`; Ada post A2 should disappear.
2. Remove `WHERE p.is_hidden = false`; Ada post A3 should add hidden engagement to Ada's totals.
3. Count `COUNT(*)` after joining likes and comments for A1; the count should become 6.
4. Remove the `LEFT JOIN` from authors to post metrics; Cy should disappear from `author_metrics`.
5. Try `COUNT(DISTINCT pl.user_id)` for likes but leave comments raw; explain why the query still hides A2.

