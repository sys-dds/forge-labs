# Data Model

## Actual tables

- `users`
- `communities`
- `community_memberships`
- `community_roles`
- `community_role_assignments`
- `community_permissions`
- `community_join_requests`
- `community_invites`
- `community_bans`
- `community_channels`
- `channel_memberships`
- `community_posts`
- `community_threads`
- `community_post_moderation_actions`
- `community_events`
- `event_rsvps`
- `event_waitlist`
- `event_attendance`
- `community_audit_log`

## Constraints

- Membership state gates private access and channel/post/event visibility.
- Role permissions are community scoped and auditable.
- Join requests and invites do not grant access until linked to active membership.
- Moderation actions suppress posts and leave audit trail.
- RSVP capacity counts only going state, while waitlist and attendance stay separate.

## Trap rows

- Ada user 1 is owner and active member of Harbor Makers community 101.
- Ben user 2 is moderator with remove_post permission but not transfer_ownership.
- Cy user 3 has pending request 3003 and no private access.
- Diya user 4 is banned by ban 5004 despite invite 4004.
- Post 8003 is removed by moderation action 10003.
- Eli user 5 is waitlisted for event 9001 in base data.

## Why this shape

The capstone proves community interaction data stays manageable when each concern has its own rows and the read contract composes them deliberately.
