SET search_path TO bip_sql_029;
SELECT variant_id, impressions, clicks, hides, reports, clicks / impressions AS click_rate, hides / impressions AS hide_rate, reports / impressions AS report_rate, 'allow' AS quality_decision
FROM variant_events
ORDER BY variant_id;
