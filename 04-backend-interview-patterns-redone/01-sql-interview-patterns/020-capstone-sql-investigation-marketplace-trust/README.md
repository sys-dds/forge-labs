# Capstone: SQL investigation query for marketplace trust

Scenario: Marketplace trust-and-safety investigation.

The query works over `sellers, listings, orders, disputes, refunds, response_events, listing_impressions, fraud_cases`. The trap rows are seller 101 is strong; seller 102 is popular but dispute/refund risky; seller 103 is cold-start; seller 104 has open fraud; seller 105 has high impressions and poor bookings; seller 106 has blocked listings only; seller 107 has no recent impressions. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
