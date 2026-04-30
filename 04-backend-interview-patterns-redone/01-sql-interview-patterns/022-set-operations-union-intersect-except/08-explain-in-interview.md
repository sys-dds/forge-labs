# Explain In Interview

## Direct answer
I would solve this with UNION, INTERSECT, and EXCEPT set reasoning, deriving the returned rows from table relationships and business thresholds rather than known IDs.

## Dataset walkthrough
Ana has safe posts and payout, Ben lacks payout, Cy has a policy violation, Diya is in fraud review, Eli has unsafe posts, and Faye is inactive.

## Query reasoning
Build eligible sets separately, intersect active/safe/payout creators, then except policy and fraud sets.

## Common mistake
The broken query uses OR predicates, so one good condition can mask a disqualifier.

## Follow-up answer
An interviewer may ask you to return disqualification reasons instead of only eligible creators.
