-- If a new row lands before page two, OFFSET can skip or repeat rows because it counts positions, not stable anchors.
CREATE VIEW offset_page_two_problem_shape AS SELECT id, body, created_at FROM posts ORDER BY created_at DESC, id DESC LIMIT 2 OFFSET 2;
