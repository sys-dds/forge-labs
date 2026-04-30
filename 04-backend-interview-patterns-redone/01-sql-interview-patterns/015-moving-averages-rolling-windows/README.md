# Moving averages and rolling windows

Scenario: Daily listing impressions.

The query works over `daily_listing_impressions`. The trap rows are listing 101 has a zero-impression day; listing 101 skips a calendar day; listing 102 has a full 3-day window; multiple listings are partitioned separately. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
