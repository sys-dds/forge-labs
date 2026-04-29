-- Author metrics collapse many posts into one backend summary per author.
CREATE VIEW author_metrics AS SELECT u.handle, count(p.id) FILTER (WHERE p.hidden=false) AS visible_posts, coalesce(sum(e.like_count),0) AS likes FROM users u LEFT JOIN posts p ON p.author_id=u.id AND p.hidden=false LEFT JOIN post_engagement_counts e ON e.id=p.id GROUP BY u.handle;
