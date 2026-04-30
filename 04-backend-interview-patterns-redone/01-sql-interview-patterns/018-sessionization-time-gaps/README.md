# Sessionization with time gaps

Scenario: User feed browsing sessions.

The query works over `feed_events`. The trap rows are user 101 has exactly a 30-minute gap that stays in session; user 101 has a 31-minute gap that starts a new session; duplicate timestamps require event_id tie-break; multiple users appear. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
