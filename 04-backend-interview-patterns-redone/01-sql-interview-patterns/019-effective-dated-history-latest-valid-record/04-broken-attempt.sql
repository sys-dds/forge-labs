SET search_path TO bip_sql_019;
WITH latest_policy AS (
  SELECT policy_version FROM trust_policies WHERE status = 'active' ORDER BY effective_from DESC LIMIT 1
)
SELECT e.event_id, e.seller_id, e.event_time, lp.policy_version
FROM seller_events e CROSS JOIN latest_policy lp
ORDER BY e.event_id;
