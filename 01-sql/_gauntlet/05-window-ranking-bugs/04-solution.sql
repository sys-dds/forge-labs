CREATE OR REPLACE VIEW gauntlet_latest_posts AS
SELECT id, author FROM (
  SELECT id, author, row_number() OVER (PARTITION BY author ORDER BY created_at DESC, id DESC) AS rn FROM posts
) ranked WHERE rn=1 ORDER BY author;
CREATE OR REPLACE VIEW gauntlet_ranked_posts AS
SELECT id, author, engagement, rank() OVER (ORDER BY engagement DESC) AS rank_label, dense_rank() OVER (ORDER BY engagement DESC) AS dense_rank_label FROM posts;
CREATE OR REPLACE VIEW gauntlet_running_totals AS
SELECT author, event_id, sum(points) OVER (PARTITION BY author ORDER BY created_at, event_id) AS running_points FROM events ORDER BY author, event_id;
