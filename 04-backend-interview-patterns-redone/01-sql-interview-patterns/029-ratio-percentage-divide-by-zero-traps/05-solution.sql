SET search_path TO bip_sql_029;
WITH rates AS (
  SELECT variant_id, impressions, clicks, hides, reports,
         ROUND(clicks::numeric / NULLIF(impressions,0), 2) AS click_rate,
         ROUND(hides::numeric / NULLIF(impressions,0), 2) AS hide_rate,
         ROUND(reports::numeric / NULLIF(impressions,0), 2) AS report_rate
  FROM variant_events
)
SELECT variant_id, impressions, clicks, hides, reports, click_rate, hide_rate, report_rate,
       CASE WHEN impressions=0 THEN 'insufficient_data'
            WHEN report_rate >= 0.05 OR hide_rate >= 0.15 THEN 'suppress'
            WHEN click_rate >= 0.20 THEN 'boost'
            ELSE 'allow' END AS quality_decision
FROM rates
ORDER BY variant_id;
