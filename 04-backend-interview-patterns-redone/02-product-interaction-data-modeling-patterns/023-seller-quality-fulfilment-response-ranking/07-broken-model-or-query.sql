SET search_path TO bip_pim_023;
WITH rating_only AS (SELECT s.seller_id,s.display_name,avg(r.rating) rating FROM sellers s JOIN seller_reviews r ON r.seller_id=s.seller_id GROUP BY s.seller_id,s.display_name), checks AS (
SELECT 'fulfilment_component' contract_name,'seller:'||display_name subject_id,'ignored' observed_value,'Broken query uses average review only' expected_reason FROM rating_only WHERE display_name='BrightSeller'
UNION ALL SELECT 'seller_treatment','seller:'||display_name,CASE WHEN rating>=4 THEN 'allow' ELSE 'review' END,'Broken treatment ignores fulfilment, cancellations, disputes, and response time' FROM rating_only WHERE display_name='RiskSeller') SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
