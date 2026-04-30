CREATE OR REPLACE VIEW gauntlet_latest_posts AS
SELECT id, author FROM (
  SELECT id, author, row_number() OVER (ORDER BY created_at DESC) AS rn FROM posts
) ranked WHERE rn=1;
CREATE OR REPLACE VIEW gauntlet_ranked_posts AS
SELECT id, author, engagement, dense_rank() OVER (ORDER BY engagement DESC) AS rank_label FROM posts;
CREATE OR REPLACE VIEW gauntlet_running_totals AS
SELECT author, event_id, sum(points) OVER (ORDER BY created_at) AS running_points FROM events;
