# Self joins for comparing rows

Scenario: Listing price history.

The query works over `price_events`. The trap rows are listing 101 has a later large drop after a small drop; listing 102 increases; listing 103 has only a small drop; listing 104 has one price event; listing 105 has same-timestamp events that require event_id tie-break. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
