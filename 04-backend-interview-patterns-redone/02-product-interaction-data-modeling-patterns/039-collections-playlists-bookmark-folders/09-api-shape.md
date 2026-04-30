# API Shape

This is only a query-contract sketch. A product API might expose:

- GET /collections/:id?viewer_id=1
- POST /collections/:id/items
- POST /collections/:id/members
- GET /collections/:id/debug

The response must derive from `bip_pim_039` rows rather than a raw text match, opaque score, or bookmark boolean.
