SET search_path TO bip_pim_006;
-- Join active follow_edges from viewer 1 to active authors, anti-join block_edges and mute_edges, filter deleted posts, and order by created_at desc then post_id desc for a stable cursor.
