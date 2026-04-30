# Deduplication with row_number

Scenario: Latest marketplace listing status events.

You will query `listing_status_events`. The important trap rows are 102 latest sold; 103 duplicate timestamp tie by event_id removed; 105 older sold then latest available. The solution must pass both the base and variant seeds, so do not hard-code answer IDs.
