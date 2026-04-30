# Explain In Interview

## Direct answer
Use `seller_events, trust_policies` to answer: For each seller event, attach the active trust policy version at the event time using effective_from inclusive and effective_to exclusive.

## Dataset walkthrough
The base dataset includes event before first policy gets no_active_policy; event exactly on boundary uses the new policy; draft overlapping policy must be ignored; open-ended current policy remains active. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution left joins active policies with event_time inside the half-open effective range and coalesces unmatched rows for investigation.

## Common mistake
It joins every event to the latest policy globally and ignores historical effective dates.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask how to detect overlapping active policy intervals before running the join.
