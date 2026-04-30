# Groups, Communities, Memberships Patterns

Clinics 031-035 keep community modeling at the data-contract level. The core rule is simple: a community object does not grant access by itself. Access comes from active `community_memberships`, suppression comes from `community_bans` or removed states, authority comes from `community_roles`, `community_role_assignments`, and `community_permissions`, and product traces come from request, invite, moderation, event, RSVP, waitlist, attendance, and audit rows.

Useful interview checks:

- `community_memberships.member_state` must distinguish `active`, `pending`, `left`, `removed`, and `banned`.
- `community_join_requests` and `community_invites` are lifecycle inputs, not membership until accepted or approved into an active membership row.
- `community_channels.channel_visibility = 'private'` must check `channel_memberships`.
- `community_posts` must be filtered by member state, channel membership, post state, and `community_post_moderation_actions`.
- `community_events` and `event_rsvps` must separate `going`, `maybe`, `declined`, and `waitlisted`; `event_attendance` is check-in evidence, not intent.
- `community_audit_log` or clinic-specific audit tables should explain request decisions, ban suppression, moderation actions, and waitlist promotion.

The trap rows are intentionally concrete: membership 1003 is left in clinic 031, request 2001 is pending in clinic 032, channel membership 5002 gates private post 1002 in clinic 033, RSVP 3005 is waitlisted in clinic 034, and capstone audit row 11003 explains removal of post 8003 in clinic 035.
