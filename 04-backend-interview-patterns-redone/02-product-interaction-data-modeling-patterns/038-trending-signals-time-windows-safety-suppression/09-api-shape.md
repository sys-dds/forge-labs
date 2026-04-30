# API Shape

This is only a query-contract sketch. A product API might expose:

- GET /trends?window_id=3001
- GET /trends/:topic_id/debug
- POST /trend-windows

The response must derive from `bip_pim_038` rows rather than a raw text match, opaque score, or bookmark boolean.
