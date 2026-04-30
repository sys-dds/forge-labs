# Data Model

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_roles`
- `community_role_assignments`
- `community_permissions`
- `community_bans`

## Constraints

- One membership row per user/community captures active, left, removed, and banned states.
- Role assignments point at community-scoped roles, not a global admin boolean.
- Permissions are checked through community_permissions and role assignments.
- Bans suppress private access even when historical membership rows exist.

## Trap rows

- Ada user 1 is active in Forge Guild community 101.
- Cy user 3 has membership 1003 with state left and must be hidden.
- Diya user 4 has membership 1004 with state banned plus ban 7001.
- Ben user 2 has moderator role 203 and can remove_post but not transfer_ownership.
- Eli user 5 has member role 204 and cannot moderate.

## Why this shape

The model separates object membership from authority. A member can be active without being a moderator, and a historical membership row cannot be treated as access.
