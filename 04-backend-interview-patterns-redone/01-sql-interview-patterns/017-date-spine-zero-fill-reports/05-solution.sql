SET search_path TO bip_sql_017;
WITH date_spine AS (
  SELECT generate_series(DATE '2026-01-01', DATE '2026-01-07', INTERVAL '1 day')::date AS booking_date
), completed_counts AS (
  SELECT booked_at AS booking_date, COUNT(*) AS booking_count
  FROM bookings
  WHERE status = 'completed'
    AND booked_at BETWEEN DATE '2026-01-01' AND DATE '2026-01-07'
  GROUP BY booked_at
)
SELECT d.booking_date, COALESCE(c.booking_count,0) AS booking_count
FROM date_spine d
LEFT JOIN completed_counts c ON c.booking_date = d.booking_date
ORDER BY d.booking_date;
