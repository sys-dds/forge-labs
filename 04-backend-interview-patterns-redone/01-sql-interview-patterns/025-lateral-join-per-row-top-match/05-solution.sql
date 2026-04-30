SET search_path TO bip_sql_025;
SELECT b.buyer_id, m.listing_id,
       CASE WHEN m.listing_id IS NULL THEN 'no_valid_listing'
            WHEN m.price_pence <= b.budget_pence THEN 'within_budget_best_trust_match'
            ELSE 'above_budget_valid_fallback' END AS match_reason,
       m.seller_trust_score
FROM buyer_intents b
LEFT JOIN LATERAL (
  SELECT l.listing_id, l.price_pence, s.seller_trust_score
  FROM listings l JOIN sellers s ON s.seller_id=l.seller_id
  WHERE l.city=b.city AND l.service_category=b.service_category AND l.status='active' AND s.blocked=false
  ORDER BY (l.price_pence <= b.budget_pence) DESC, s.seller_trust_score DESC, l.distance_km ASC, l.listing_id ASC
  LIMIT 1
) m ON true
ORDER BY b.buyer_id;
