-- HAVING filters after aggregation, such as authors with enough visible activity.
CREATE VIEW active_authors AS SELECT handle FROM author_metrics WHERE visible_posts >= 1 AND likes >= 1 ORDER BY handle;
