SET search_path TO bip_sql_025;
SELECT b.buyer_id, l.listing_id, 'global_limit_match' AS match_reason, s.seller_trust_score
FROM buyer_intents b
LEFT JOIN (SELECT * FROM listings WHERE status='active' ORDER BY price_pence LIMIT 1) l ON true
LEFT JOIN sellers s ON s.seller_id=l.seller_id
ORDER BY b.buyer_id;
