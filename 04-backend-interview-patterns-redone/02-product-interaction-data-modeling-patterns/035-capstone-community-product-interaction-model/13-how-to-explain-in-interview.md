# How To Explain In Interview

## Direct answer

Compose a small community model from explicit lifecycle tables: memberships, roles, requests/invites, bans, channels/posts/threads, moderation, events, RSVPs, waitlist, attendance, and audit log.

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

## Actual trap rows

- Ada user 1 is owner and active member of Harbor Makers community 101.
- Ben user 2 is moderator with remove_post permission but not transfer_ownership.
- Cy user 3 has pending request 3003 and no private access.
- Diya user 4 is banned by ban 5004 despite invite 4004.
- Post 8003 is removed by moderation action 10003.
- Eli user 5 is waitlisted for event 9001 in base data.

## Exact query mechanics

The query builds separate CTEs for membership, permissions, access, channel visibility, visible threads, moderation audit, RSVP capacity, waitlist, attendance, and debug trace, then emits the ten capstone contracts.

## Write path

Create community 101 and active memberships for Ada and Ben. Assign owner and moderator roles with permission rows. Record Cy pending request 3003 and Diya banned invite 4004. Insert public/private channel posts, thread 8501, moderation action 10003, event 9001, waitlist 9305, attendance 9401, and community_audit_log rows.

## Community/product follow-up

This is enough to discuss community product behavior without claiming to design a whole Discord, Reddit, or Facebook Groups platform.

## Scaling follow-up

The follow-up is indexing and read-model materialization, not platform infrastructure by default.
