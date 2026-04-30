SET search_path TO bip_sql_009;
WITH first_posts AS (
  SELECT c.creator_id, c.signup_date AS cohort_date, MIN(a.activity_date) AS first_post_date
  FROM creators c JOIN creator_activity a ON a.creator_id = c.creator_id
  GROUP BY c.creator_id, c.signup_date
)
SELECT fp.cohort_date, COUNT(DISTINCT fp.creator_id) AS creators,
       COUNT(DISTINCT a.creator_id) AS day_1_retained,
       COUNT(DISTINCT a.creator_id) AS day_7_retained
FROM first_posts fp
LEFT JOIN creator_activity a ON a.creator_id = fp.creator_id AND a.activity_date > fp.first_post_date
GROUP BY fp.cohort_date
ORDER BY fp.cohort_date;
