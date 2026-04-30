# API Shape

This clinic only sketches query contracts. A thin product API would expose:

- POST /communities/:id/join-requests
- POST /communities/:id/invites/:token/accept
- POST /communities/:id/join-requests/:id/decision
- GET /communities/:id/private-access-contract

The important part is that responses derive from `bip_pim_032` tables, not from a global community flag or cached boolean.
