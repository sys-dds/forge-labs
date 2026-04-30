# Debugging Notes

Candidate generation comes before ranking because eligibility is binary. Cy post 201 cannot be "ranked lower" for Ada; Ada muted Cy, so the row must not reach the ranking input.

Noor post 301 is followed by path `Ada -> follows -> Noor -> posts`, but Ada blocked Noor. The broken query stops at the follow join, so Noor post 301 appears even though the block row says it is unsafe for this viewer.

Ben post 102 has one like and zero comments. A direct inner join to `comments` removes it entirely, which is why optional child tables need a `LEFT JOIN` or a pre-aggregated summary.

Ben post 101 has two likes and three comments. Joining likes and comments directly creates six joined rows before grouping; the fixed query counts likes and comments separately.

Ben post 103 is hidden. Hidden content must be removed before the feed result exists, because later ranking code should never receive a hidden post as a candidate.

