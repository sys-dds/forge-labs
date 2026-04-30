SET search_path TO bip_pim_022;
WITH newest AS (SELECT * FROM listings WHERE status='active' ORDER BY created_rank DESC LIMIT 4), checks AS (
SELECT 'category_match_component' contract_name,'listing:'||listing_id subject_id,'ignored' observed_value,'Broken query ignores buyer category intent' expected_reason FROM newest ORDER BY created_rank DESC LIMIT 1)
SELECT * FROM checks
UNION ALL SELECT 'price_match_component','listing:'||listing_id,'ignored','Broken query ignores price range' FROM newest ORDER BY contract_name;
