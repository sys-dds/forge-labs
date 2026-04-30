CREATE OR REPLACE VIEW seller_trust_summary AS
WITH l AS (SELECT seller_id, count(*)::integer AS active_listing_count FROM listings WHERE NOT hidden GROUP BY seller_id),
r AS (
  SELECT seller_id,
    count(*) FILTER (WHERE verified AND NOT hidden)::integer AS verified_review_count,
    count(*) FILTER (WHERE suspicious AND NOT hidden)::integer AS suspicious_review_count
  FROM reviews GROUP BY seller_id
),
d AS (
  SELECT seller_id,
    count(*) FILTER (WHERE status='open')::integer AS open_dispute_count,
    count(*) FILTER (WHERE status='resolved')::integer AS resolved_dispute_count
  FROM disputes GROUP BY seller_id
)
SELECT u.handle AS seller_handle, coalesce(l.active_listing_count,0) AS active_listing_count,
  coalesce(r.verified_review_count,0) AS verified_review_count,
  coalesce(r.suspicious_review_count,0) AS suspicious_review_count,
  coalesce(d.open_dispute_count,0) AS open_dispute_count,
  coalesce(d.resolved_dispute_count,0) AS resolved_dispute_count
FROM users u LEFT JOIN l ON l.seller_id=u.id LEFT JOIN r ON r.seller_id=u.id LEFT JOIN d ON d.seller_id=u.id
WHERE u.role='seller' ORDER BY u.handle;
