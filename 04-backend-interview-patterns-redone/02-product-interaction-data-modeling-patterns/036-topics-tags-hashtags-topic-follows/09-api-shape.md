# API Shape

This is only a query-contract sketch. A product API might expose:

- GET /topics/:id/surface?viewer_id=1
- POST /topics/:id/follows
- GET /topics/:id/debug-trace

The response must derive from `bip_pim_036` rows rather than a raw text match, opaque score, or bookmark boolean.
