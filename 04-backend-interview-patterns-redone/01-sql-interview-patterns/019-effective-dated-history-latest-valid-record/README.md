# Effective-dated history / latest valid record

Scenario: Seller trust policy versions.

The query works over `seller_events, trust_policies`. The trap rows are event before first policy gets no_active_policy; event exactly on boundary uses the new policy; draft overlapping policy must be ignored; open-ended current policy remains active. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
