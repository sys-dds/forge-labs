# Explain In Interview

## Direct answer
Use `creators` to answer: Segment creators into 4 quality buckets based on trust-adjusted engagement score.

## Dataset walkthrough
The base dataset includes creator 102 has high engagement but many reports; creator 103 has low engagement but high trust; creators 101 and 104 tie; eight creators fill all four buckets. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution calculates score from completed posts, dwell time, trust, hide penalty, and report penalty, then applies RANK and NTILE over that computed score.

## Common mistake
It buckets by follower count instead of the trust-adjusted engagement score.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask whether ties should stay in the same bucket and compare NTILE with DENSE_RANK bands.
