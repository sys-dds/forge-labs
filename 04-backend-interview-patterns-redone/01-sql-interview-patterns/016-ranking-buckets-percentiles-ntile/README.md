# Ranking buckets, percentiles, and NTILE

Scenario: Creator quality tiers.

The query works over `creators`. The trap rows are creator 102 has high engagement but many reports; creator 103 has low engagement but high trust; creators 101 and 104 tie; eight creators fill all four buckets. The base and variant seeds use different IDs and values, so the solution has to derive the answer from relational rules.
