# API Shape

This clinic only sketches query contracts. A thin product API would expose:

- GET /communities/:id/debug-contract
- GET /communities/:id/channels/:id/posts
- POST /communities/:id/join-requests/:id/decision
- POST /communities/:id/events/:id/rsvps
- POST /communities/:id/moderation-actions

The important part is that responses derive from `bip_pim_035` tables, not from a global community flag or cached boolean.
