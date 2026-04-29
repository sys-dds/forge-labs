-- Running totals show how an author's engagement accumulates over time.
CREATE VIEW running_engagement_total AS SELECT p.author_id, p.id, sum(e.engagement) OVER (PARTITION BY p.author_id ORDER BY p.created_at, p.id) AS running_total FROM posts p JOIN post_engagement e ON e.id=p.id;
