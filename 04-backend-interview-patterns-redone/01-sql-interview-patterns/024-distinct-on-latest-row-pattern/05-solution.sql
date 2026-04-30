SET search_path TO bip_sql_024;
WITH latest_decision AS (
  SELECT DISTINCT ON (listing_id) listing_id, decision_id, decision, decided_at, reviewer
  FROM moderation_decisions
  ORDER BY listing_id, decided_at DESC, decision_id DESC
)
SELECT l.listing_id, ld.decision_id, COALESCE(ld.decision, 'no_decision') AS decision, ld.decided_at, ld.reviewer
FROM listings l LEFT JOIN latest_decision ld ON ld.listing_id=l.listing_id
WHERE l.deleted=false
ORDER BY l.listing_id;
