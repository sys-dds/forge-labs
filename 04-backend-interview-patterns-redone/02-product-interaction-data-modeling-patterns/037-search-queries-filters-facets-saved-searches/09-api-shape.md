# API Shape

This is only a query-contract sketch. A product API might expose:

- POST /search/sessions/:id/queries
- GET /search/results?query_id=1001
- POST /saved-searches
- GET /search/debug?query_id=1001

The response must derive from `bip_pim_037` rows rather than a raw text match, opaque score, or bookmark boolean.
