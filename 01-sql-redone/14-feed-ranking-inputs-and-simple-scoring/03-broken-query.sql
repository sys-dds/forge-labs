CREATE VIEW ada_ranked_feed_inputs AS
SELECT
  candidate_rows.post_id,
  author.handle AS author_handle,
  candidate_rows.candidate_reason,
  candidate_rows.like_count,
  candidate_rows.comment_count,
  candidate_rows.recency_bucket,
  0 AS author_affinity_score,
  candidate_rows.like_count AS engagement_score,
  0 AS recency_score,
  candidate_rows.like_count AS raw_score,
  'hidden' AS diversity_group,
  ROW_NUMBER() OVER (ORDER BY candidate_rows.like_count DESC) AS rank_position
FROM feed_candidates candidate_rows
JOIN users author ON author.id = candidate_rows.author_id;
