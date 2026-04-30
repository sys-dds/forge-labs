# Conditional aggregation with CASE

Scenario: Seller fulfilment quality from order statuses.

You will query `sellers, orders`. The important trap rows are 103 has zero completed orders; 102 has dispute and refund; pending rows stay in denominator. The solution must pass both the base and variant seeds, so do not hard-code answer IDs.
