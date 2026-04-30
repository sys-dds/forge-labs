CREATE VIEW ada_ranked_feed_inputs AS
WITH feature_rows AS (
  SELECT
    candidate_rows.post_id,
    author.handle AS author_handle,
    candidate_rows.candidate_reason,
    candidate_rows.like_count,
    candidate_rows.comment_count,
    candidate_rows.recency_bucket,
    CASE candidate_rows.candidate_reason
      WHEN 'followed_author' THEN 10
      WHEN 'shared_group' THEN 6
      WHEN 'liked_by_following' THEN 3
      WHEN 'reposted_by_following' THEN 4
    END AS author_affinity_score,
    candidate_rows.like_count * 2 + candidate_rows.comment_count * 4 AS engagement_score,
    CASE candidate_rows.recency_bucket WHEN 'recent' THEN 5 ELSE 1 END AS recency_score,
    COUNT(*) OVER (PARTITION BY author.handle) AS author_candidate_count,
    candidate_rows.created_at
  FROM feed_candidates candidate_rows
  JOIN users author ON author.id = candidate_rows.author_id
)
SELECT
  post_id,
  author_handle,
  candidate_reason,
  like_count,
  comment_count,
  recency_bucket,
  author_affinity_score,
  engagement_score,
  recency_score,
  engagement_score + author_affinity_score + recency_score AS raw_score,
  CASE WHEN author_candidate_count > 1 THEN 'repeated_author:' || author_handle ELSE 'single_author:' || author_handle END AS diversity_group,
  ROW_NUMBER() OVER (
    ORDER BY engagement_score + author_affinity_score + recency_score DESC, created_at DESC, post_id DESC
  ) AS rank_position
FROM feature_rows;

