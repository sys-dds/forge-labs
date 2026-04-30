SET search_path TO bip_pim_024;
WITH offer_bookings AS (SELECT l.listing_id,count(*) booking_count FROM offers o JOIN listings l ON l.listing_id=o.listing_id GROUP BY l.listing_id), checks AS (
SELECT 'pending_offer_not_booking' contract_name,'listing:'||listing_id subject_id,booking_count::text observed_value,'Broken query treats every offer as a booking' expected_reason FROM offer_bookings WHERE listing_id=101
UNION ALL SELECT 'availability_debug_trace','listing:'||listing_id,'offers_as_bookings='||booking_count,'Broken trace ignores capacity, cancellation, demand, and supply' FROM offer_bookings WHERE listing_id=101) SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
