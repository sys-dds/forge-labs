SET search_path TO bip_pim_012;
-- Build visible_posts by joining posts to users, accepted friendships, audience group membership, and block_edges for viewer 1; then emit visible and hidden contract counts.
