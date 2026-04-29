CREATE VIEW running_engagement_total AS
SELECT p.author_id, e.id AS event_id, p.id AS post_id,
       count(*) OVER (PARTITION BY p.author_id ORDER BY e.created_at, e.id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM engagement_events e JOIN posts p ON p.id = e.post_id
ORDER BY p.author_id, e.created_at, e.id;

