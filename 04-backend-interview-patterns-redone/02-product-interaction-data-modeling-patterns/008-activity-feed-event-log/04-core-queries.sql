SET search_path TO bip_pim_008;
-- Join activity_events to actor, object liveness, visibility_rules, follow_edges, and block_edges; owner-private visibility is allowed; order by created_at desc then event_id desc.
