# How To Explain In Interview

## Direct answer

Use communities for the group object, community_memberships for lifecycle state, community_roles and community_role_assignments for authority, community_permissions for allowed actions, and community_bans for suppression.

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_roles`
- `community_role_assignments`
- `community_permissions`
- `community_bans`

## Actual trap rows

- Ada user 1 is active in Forge Guild community 101.
- Cy user 3 has membership 1003 with state left and must be hidden.
- Diya user 4 has membership 1004 with state banned plus ban 7001.
- Ben user 2 has moderator role 203 and can remove_post but not transfer_ownership.
- Eli user 5 has member role 204 and cannot moderate.

## Exact query mechanics

The query builds active_members, banned_users, and role_permissions CTEs, then emits contract rows such as active_member_visible, moderator_permission_contract, and membership_lifecycle_trace from joins over those tables.

## Write path

Create community 101 owned by Ada. Insert community_memberships rows for active, left, and banned states. Assign owner, admin, moderator, and member roles through community_role_assignments. Store permission rows such as remove_post and transfer_ownership in community_permissions.

## Community/product follow-up

You can add channel or event rows later, but they should still depend on the same membership and permission contract.

## Scaling follow-up

At larger size, precompute permission summaries if needed, but keep the source rows auditable.
