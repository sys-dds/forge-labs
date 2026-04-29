CREATE VIEW pagination_capstone AS
SELECT 'keyset_page_one' AS page, array_agg(id ORDER BY created_at DESC, id DESC) AS ids FROM keyset_page_one
UNION ALL
SELECT 'keyset_page_two', array_agg(id ORDER BY created_at DESC, id DESC) FROM keyset_page_two
UNION ALL
SELECT 'offset_after_insert', array_agg(id ORDER BY created_at DESC, id DESC) FROM offset_page_two_after_insert;

