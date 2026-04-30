SET search_path TO bip_pim_021;
WITH ranked AS (SELECT creator_id,display_name,popularity FROM creators ORDER BY popularity DESC LIMIT 4), checks AS (
SELECT 'popular_creator_capped' contract_name,'creator:'||display_name subject_id,'eligible' observed_value,'Broken popularity-only ranking ignores exposure budget spend' expected_reason FROM ranked WHERE display_name='MegaMaker'
UNION ALL SELECT 'long_tail_creator_exposed','creator:'||display_name,'not_exposed','Broken ranking hides long-tail creators behind popularity' FROM ranked WHERE display_name='QuietCraft'
UNION ALL SELECT 'low_quality_creator_not_boosted','creator:'||display_name,'boosted','Broken ranking does not inspect quality components' FROM ranked WHERE display_name='LowLift'
UNION ALL SELECT 'repeated_creator_suppressed','creator:'||display_name,'eligible','Broken ranking ignores viewer seen rows' FROM ranked WHERE display_name='RepeatRay'
UNION ALL SELECT 'exposure_budget_remaining','creator:'||display_name,'unknown','Broken ranking has no budget trace' FROM ranked WHERE display_name='MegaMaker'
UNION ALL SELECT 'exposure_spend_derived','creator:'||display_name,'unknown','Broken ranking has no exposure event spend' FROM ranked WHERE display_name='MegaMaker'
UNION ALL SELECT 'exposure_decision_trace','surface:home',string_agg(display_name||':popularity='||popularity,';' ORDER BY popularity DESC),'Broken trace is popularity only' FROM ranked
UNION ALL SELECT 'variant_exposure_change','surface:home','creator:'||(SELECT display_name FROM ranked ORDER BY popularity DESC LIMIT 1),'Broken variant still picks the most popular creator')
SELECT contract_name,subject_id,observed_value,expected_reason FROM checks ORDER BY contract_name;
