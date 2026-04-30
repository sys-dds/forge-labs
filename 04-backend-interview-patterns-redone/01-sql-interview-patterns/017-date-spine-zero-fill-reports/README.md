# Date spine and zero-fill reports

Scenario: Daily marketplace bookings.

The query works over `bookings`. The trap rows are 2026-01-02 has only a cancelled booking; 2026-01-03 has no rows; 2026-01-08 is outside the range; 2026-01-01 has multiple completed bookings. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
