INSERT INTO users (id, handle) VALUES
  (1, 'ada'), (2, 'ben'), (3, 'maya'), (4, 'lina');

INSERT INTO feed_candidates (post_id, author_id, candidate_reason, recency_bucket, like_count, comment_count, created_at) VALUES
  (101, 2, 'followed_author', 'recent', 2, 3, '2026-01-01 10:05:00'),
  (102, 2, 'followed_author', 'older', 5, 1, '2026-01-01 09:00:00'),
  (301, 3, 'shared_group', 'recent', 1, 2, '2026-01-01 10:04:00'),
  (601, 4, 'liked_by_following', 'recent', 4, 0, '2026-01-01 10:03:00'),
  (602, 4, 'reposted_by_following', 'older', 1, 1, '2026-01-01 08:00:00');

INSERT INTO prior_replies (viewer_id, author_id, reply_count) VALUES
  (1, 2, 2);

