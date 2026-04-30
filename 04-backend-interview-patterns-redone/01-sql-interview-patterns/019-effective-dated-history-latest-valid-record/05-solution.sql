SET search_path TO bip_sql_019;
SELECT e.event_id, e.seller_id, e.event_time,
       COALESCE(p.policy_version, 'no_active_policy') AS policy_version
FROM seller_events e
LEFT JOIN trust_policies p
  ON p.status = 'active'
 AND e.event_time >= p.effective_from
 AND (p.effective_to IS NULL OR e.event_time < p.effective_to)
ORDER BY e.event_id;
