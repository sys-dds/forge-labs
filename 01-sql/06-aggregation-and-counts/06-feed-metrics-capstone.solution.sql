-- Capstone: feed metrics are candidate features for later ranking.
CREATE VIEW feed_metrics_capstone AS SELECT * FROM post_engagement_counts ORDER BY id;
