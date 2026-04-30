# Model Answer

I would model users, posts, directed follows, mutes, and blocks. Follows use `(follower_id, followee_id)` as the key and reject self-follows. Blocks and mutes are viewer-specific edges, so Ada blocking Noor is a row that feed and suggestion queries can exclude with `NOT EXISTS`.
