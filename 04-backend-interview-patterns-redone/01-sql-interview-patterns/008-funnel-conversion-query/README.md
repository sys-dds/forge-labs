# Funnel conversion query

Scenario: Marketplace buyer funnel events.

You will query `funnel_events`. The important trap rows are 103 contacts before view; 102 skips contacted; 104 repeats contacted; 105 reaches booking only. The solution must pass both the base and variant seeds, so do not hard-code answer IDs.

The `funnel_steps` table provides the interview step labels and their deterministic order, so the query does not manufacture final rows from string literals.
