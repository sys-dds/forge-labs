# Interview Explanation

Feed ranking should run after candidate filtering.

The candidate query first answers whether a post is allowed to compete at all: the author must be followed, not muted, and not blocked. Only after that should ranking score the eligible rows. Engagement counts are prepared with separate aggregate subqueries so likes and comments do not multiply each other.

The quiet Ben post matters because a real feed can include posts with no comments yet. An inner join would silently convert "zero comments" into "not eligible," which is a different product rule.
