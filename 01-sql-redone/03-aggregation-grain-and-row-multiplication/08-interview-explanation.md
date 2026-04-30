# Interview Explanation

## Direct answer

First choose the output grain. For post metrics it is one row per visible post, so I aggregate likes and comments separately and join those summaries back to posts.

## Dataset walkthrough

Ada post A1 has two likes and three comments, so the raw child join has six rows. Ada post A2 has zero comments and must still appear with one like. Ada post A3 is hidden and must not count. Ben post B1 should show three likes and one comment. Cy should show zero visible posts in the author summary.

## Common mistake

The common mistake is using `COUNT(*)` after joining independent child tables. The count measures joined combinations, not likes or comments.

## Senior trade-off

`COUNT(DISTINCT)` can be acceptable for a quick one-off metric. For backend queries that feed ranking or profile cards, pre-aggregation is clearer because each subquery declares its grain.

