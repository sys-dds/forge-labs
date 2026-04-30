# API Shape

This clinic only sketches query contracts. A thin product API would expose:

- GET /communities/:id/viewer-contract
- POST /communities/:id/memberships
- POST /communities/:id/role-assignments
- GET /communities/:id/permission-checks

The important part is that responses derive from `bip_pim_031` tables, not from a global community flag or cached boolean.
