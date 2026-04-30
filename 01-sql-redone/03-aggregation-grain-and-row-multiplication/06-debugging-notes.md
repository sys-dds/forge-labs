# Debugging Notes

Posts are at post grain: Ada post A1 is one row in `posts`. Likes are at like grain: A1 has two child rows. Comments are at comment grain: A1 has three child rows. Joining both children directly creates six A1 rows before the count happens.

Ada post A2 has one like and zero comments. The broken inner join to comments drops A2, so Ada's profile loses a visible post and one like.

Ada post A3 is hidden. The broken query includes A3 and can add five likes and five comments to Ada's totals even though hidden posts must not feed profile metrics or ranking input.

Ben post B1 is useful because it has three likes and one comment. It proves the fix works when both child tables exist without relying only on Ada's A1, A2, and A3 rows.

Cy has no posts. The author summary keeps Cy with zero counts by left joining author rows to post summaries.

`COUNT(DISTINCT)` can patch one metric, but it becomes harder to read when you need several child summaries. Pre-aggregating likes and comments makes the output grain visible in the query.
