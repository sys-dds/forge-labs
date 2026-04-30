SET search_path TO bip_sql_009;
WITH first_posts AS (
  SELECT c.creator_id, c.signup_date AS cohort_date, MIN(a.activity_date) AS first_post_date
  FROM creators c
  JOIN creator_activity a ON a.creator_id = c.creator_id AND a.activity_type = 'post'
  GROUP BY c.creator_id, c.signup_date
), retained AS (
  SELECT fp.creator_id, fp.cohort_date,
         MAX(CASE WHEN a.activity_date = fp.first_post_date + 1 THEN 1 ELSE 0 END) AS retained_day_1,
         MAX(CASE WHEN a.activity_date = fp.first_post_date + 7 THEN 1 ELSE 0 END) AS retained_day_7
  FROM first_posts fp
  LEFT JOIN creator_activity a ON a.creator_id = fp.creator_id AND a.activity_type = 'post'
  GROUP BY fp.creator_id, fp.cohort_date
)
SELECT cohort_date, COUNT(*) AS creators,
       SUM(retained_day_1) AS day_1_retained,
       SUM(retained_day_7) AS day_7_retained
FROM retained
GROUP BY cohort_date
ORDER BY cohort_date;
