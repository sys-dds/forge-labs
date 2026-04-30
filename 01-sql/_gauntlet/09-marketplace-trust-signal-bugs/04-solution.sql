CREATE OR REPLACE VIEW gauntlet_result AS
WITH listing_counts AS (
  SELECT seller_id, count(*)::integer AS active_listing_count FROM listings WHERE NOT hidden GROUP BY seller_id
),
review_counts AS (
  SELECT seller_id,
    count(*) FILTER (WHERE verified AND NOT hidden)::integer AS verified_review_count,
    count(*) FILTER (WHERE suspicious AND NOT hidden)::integer AS suspicious_review_count
  FROM reviews GROUP BY seller_id
),
dispute_counts AS (
  SELECT seller_id,
    count(*) FILTER (WHERE status='open')::integer AS open_dispute_count,
    count(*) FILTER (WHERE status='resolved')::integer AS resolved_dispute_count
  FROM disputes GROUP BY seller_id
)
SELECT seller.handle AS seller_handle,
  coalesce(lc.active_listing_count,0) AS active_listing_count,
  coalesce(rc.verified_review_count,0) AS verified_review_count,
  coalesce(rc.suspicious_review_count,0) AS suspicious_review_count,
  coalesce(dc.open_dispute_count,0) AS open_dispute_count,
  coalesce(dc.resolved_dispute_count,0) AS resolved_dispute_count
FROM users seller
LEFT JOIN listing_counts lc ON lc.seller_id=seller.id
LEFT JOIN review_counts rc ON rc.seller_id=seller.id
LEFT JOIN dispute_counts dc ON dc.seller_id=seller.id
WHERE seller.role='seller'
ORDER BY seller.handle;
