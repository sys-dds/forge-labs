# Explain In Interview

## Direct answer
Use `bookings` to answer: Produce daily completed booking counts from 2026-01-01 through 2026-01-07 inclusive, including zero days.

## Dataset walkthrough
The base dataset includes 2026-01-02 has only a cancelled booking; 2026-01-03 has no rows; 2026-01-08 is outside the range; 2026-01-01 has multiple completed bookings. Those rows exist so a shortcut or known-dataset query gives the wrong answer.

## Query reasoning
The solution builds a date spine with generate_series, aggregates completed bookings by date, then left joins counts onto every date.

## Common mistake
It groups bookings directly, so dates with no completed bookings vanish from the report.

## Senior trade-off
Prefer visible CTEs, row-grain comments in your explanation, and deterministic ordering over a compact query that hides why rows survived.

## Follow-up answer
Ask for a per-city date spine with zero-fill for every city/date pair.
