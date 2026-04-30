# Read/Write Path

## Write path

Create posts with visibility and optional audience_group_id, maintain friendship and audience_group_members rows separately, and write block_edges as an override.

## Read path

Build visible_posts by joining posts to users, accepted friendships, audience group membership, and block_edges for viewer 1; then emit visible and hidden contract counts.
