SET search_path TO bip_pim_025;
WITH popularity AS (SELECT listing_id,popularity FROM listings WHERE status='active' ORDER BY popularity DESC LIMIT 2), checks AS (
SELECT 'creator_exposure_contract' contract_name,'listing:'||listing_id subject_id,'ignored' observed_value,'Broken query ignores creator exposure budgets' expected_reason FROM popularity ORDER BY popularity DESC LIMIT 1)
SELECT * FROM checks
UNION ALL SELECT 'marketplace_debug_trace_contract','listing:'||listing_id,'popularity='||popularity,'Broken query ignores buyer intent, quality components, availability, supply demand, risk, and treatment' FROM popularity ORDER BY contract_name;
