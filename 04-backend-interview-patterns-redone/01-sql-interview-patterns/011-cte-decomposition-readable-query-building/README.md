# CTE decomposition and readable query building

Scenario: Marketplace seller eligibility for weekly promotion.

The query works over `sellers, listings, orders, listing_impressions`. The trap rows are seller 102 has enough listings but weak fulfilment; seller 103 has good fulfilment but no recent impressions; seller 104 has recent impressions but too few completed orders; seller 105 is inactive; seller 101 is eligible. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
