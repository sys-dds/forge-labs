CREATE VIEW matching_capstone AS
SELECT 'mutual_match' AS result_set, user_b_handle AS handle FROM mutual_matches WHERE user_a_handle = 'ada'
UNION ALL SELECT 'raw_candidate', handle FROM ada_raw_matching_candidates
UNION ALL SELECT 'preference_fit', handle FROM ada_preference_fit_candidates
ORDER BY result_set, handle;

