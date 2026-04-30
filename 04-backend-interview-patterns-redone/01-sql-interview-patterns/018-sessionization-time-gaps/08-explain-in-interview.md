# Explain In Interview

## Direct answer
Use `feed_events` to answer: Group feed events into sessions where a new session starts after more than 30 minutes of inactivity.

## Dataset walkthrough
The base dataset includes user 101 has exactly a 30-minute gap that stays in session; user 101 has a 31-minute gap that starts a new session; duplicate timestamps require event_id tie-break; multiple users appear. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution orders events per user, marks rows where the prior event is more than 30 minutes away, then cumulatively sums those markers into session numbers.

## Common mistake
It groups every event per user into one session and misses inactivity boundaries.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for session duration in minutes and average events per session.
