SET search_path TO bip_sql_013;
WITH sequenced AS (
  SELECT listing_id, price_pence, changed_at, price_event_id,
         ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY changed_at, price_event_id) AS rn
  FROM price_events
)
SELECT cur.listing_id,
       prev.price_pence AS previous_price_pence,
       cur.price_pence AS current_price_pence,
       ROUND(((prev.price_pence - cur.price_pence)::numeric / prev.price_pence) * 100, 2) AS drop_percent,
       cur.changed_at
FROM sequenced cur
JOIN sequenced prev ON prev.listing_id = cur.listing_id AND prev.rn = cur.rn - 1
WHERE cur.price_pence <= prev.price_pence * 0.80
ORDER BY cur.listing_id, cur.changed_at, cur.price_event_id;
