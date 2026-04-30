# API Shape

This clinic only sketches query contracts. A thin product API would expose:

- GET /communities/:id/channels/:id/posts
- GET /communities/:id/pinned-posts
- GET /communities/:id/threads/:id
- POST /communities/:id/posts/:id/moderation-actions

The important part is that responses derive from `bip_pim_033` tables, not from a global community flag or cached boolean.
