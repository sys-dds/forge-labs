SET search_path TO bip_sql_024;
WITH latest AS (SELECT listing_id, MAX(decided_at) AS decided_at FROM moderation_decisions GROUP BY listing_id)
SELECT l.listing_id, md.decision_id, COALESCE(md.decision,'no_decision') AS decision, md.decided_at, md.reviewer
FROM listings l LEFT JOIN latest x ON x.listing_id=l.listing_id LEFT JOIN moderation_decisions md ON md.listing_id=x.listing_id AND md.decided_at=x.decided_at
WHERE l.deleted=false
ORDER BY l.listing_id, md.decision_id;
