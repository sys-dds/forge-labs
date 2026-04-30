SET search_path TO bip_sql_013;
SELECT p.listing_id, MAX(old.price_pence) AS previous_price_pence, p.price_pence AS current_price_pence,
       ROUND(((MAX(old.price_pence) - p.price_pence)::numeric / MAX(old.price_pence)) * 100, 2) AS drop_percent, p.changed_at
FROM price_events p
JOIN price_events old ON old.listing_id = p.listing_id AND old.changed_at <= p.changed_at AND old.price_event_id <> p.price_event_id
GROUP BY p.listing_id, p.price_pence, p.changed_at, p.price_event_id
HAVING p.price_pence <= MAX(old.price_pence) * 0.80
ORDER BY p.listing_id, p.changed_at, p.price_event_id;
