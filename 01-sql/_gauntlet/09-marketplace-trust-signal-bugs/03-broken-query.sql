CREATE OR REPLACE VIEW gauntlet_result AS
SELECT seller.handle AS seller_handle,
  count(DISTINCT listings.id)::integer AS active_listing_count,
  count(reviews.id)::integer AS verified_review_count,
  count(*) FILTER (WHERE reviews.suspicious)::integer AS suspicious_review_count,
  count(disputes.id)::integer AS open_dispute_count,
  count(disputes.id)::integer AS resolved_dispute_count
FROM users seller
LEFT JOIN listings ON listings.seller_id=seller.id
LEFT JOIN reviews ON reviews.seller_id=seller.id
LEFT JOIN disputes ON disputes.seller_id=seller.id
WHERE seller.role='seller'
GROUP BY seller.handle ORDER BY seller.handle;
