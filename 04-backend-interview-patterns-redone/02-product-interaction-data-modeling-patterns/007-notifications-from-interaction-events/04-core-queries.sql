SET search_path TO bip_pim_007;
-- Map interaction_events to recipient rules, suppress actor=recipient, dedupe notifications by recipient/actor/type/subject, and count only unread notification_state rows.
