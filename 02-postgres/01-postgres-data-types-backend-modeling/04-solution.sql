CREATE VIEW backend_type_checks AS
SELECT r.id AS request_id, l.price, r.payment_boundary_amount, r.requested_at > l.created_at AS request_after_listing, u.active, l.seller_id::text ~ '^[0-9a-f-]{36}$' AS seller_uuid_text
FROM service_requests r JOIN listings l ON l.id=r.listing_id JOIN backend_users u ON u.id=r.buyer_id;
