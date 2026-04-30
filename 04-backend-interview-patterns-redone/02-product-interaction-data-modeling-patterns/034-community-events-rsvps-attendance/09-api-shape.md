# API Shape

This clinic only sketches query contracts. A thin product API would expose:

- POST /communities/:id/events/:id/rsvps
- POST /events/:id/waitlist/promote
- POST /events/:id/check-in
- GET /communities/:id/upcoming-events

The important part is that responses derive from `bip_pim_034` tables, not from a global community flag or cached boolean.
