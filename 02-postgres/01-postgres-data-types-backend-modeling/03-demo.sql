SELECT handle, role, active FROM backend_users ORDER BY handle;
SELECT r.id, l.price, r.payment_boundary_amount, r.requested_at AT TIME ZONE 'UTC' AS requested_utc
FROM service_requests r
JOIN listings l ON l.id = r.listing_id;
