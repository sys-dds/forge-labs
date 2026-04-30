SET search_path TO bip_sql_015;
SELECT listing_id, activity_date, impressions,
       ROUND(AVG(impressions) OVER (PARTITION BY listing_id ORDER BY activity_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg_3_day
FROM daily_listing_impressions
ORDER BY listing_id, activity_date;
