# Read/Write Path

## Write path

- Record session 1101 and query 1001.
- Store filter 2001 and facet row 3001.
- Store active saved search 4001 and paused saved search 4002.
- Write hidden treatment 8001 and block 9001.

## Read path

- Apply filters before returning results.
- Derive facet counts from visible filtered results.
- Check saved_searches.saved_state before alert eligibility.
- Suppress deleted, hidden, and blocked-author results.

The verification query is the product read contract over those source rows.
