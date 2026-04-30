SET search_path TO bip_sql_017;
SELECT booked_at AS booking_date, COUNT(*) AS booking_count
FROM bookings
WHERE status = 'completed'
  AND booked_at BETWEEN DATE '2026-01-01' AND DATE '2026-01-07'
GROUP BY booked_at
ORDER BY booked_at;
