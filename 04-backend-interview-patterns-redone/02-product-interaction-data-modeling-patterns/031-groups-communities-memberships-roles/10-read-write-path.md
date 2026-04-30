# Read/Write Path

## Write path

- Create community 101 owned by Ada.
- Insert community_memberships rows for active, left, and banned states.
- Assign owner, admin, moderator, and member roles through community_role_assignments.
- Store permission rows such as remove_post and transfer_ownership in community_permissions.

## Read path

- Join viewer membership where member_state = active.
- Exclude viewers present in community_bans.
- Resolve permissions through role assignments plus community_permissions.
- Return trace strings showing membership and role row ids.

The verification query is intentionally a read contract over stored rows.
