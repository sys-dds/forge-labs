# API Shape

This is only a query-contract sketch. A product API might expose:

- GET /discovery/home?viewer_id=1
- GET /search/results?query_id=9001
- GET /trends/:window_id
- GET /collections/:id
- GET /discovery/debug

The response must derive from `bip_pim_040` rows rather than a raw text match, opaque score, or bookmark boolean.
