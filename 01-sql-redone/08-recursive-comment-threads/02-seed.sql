INSERT INTO posts (id, title) VALUES
  (100, 'Ada target post'),
  (200, 'Unrelated post');

INSERT INTO comments (id, post_id, parent_id, body, sort_order) VALUES
  ('c1', 100, NULL, 'root c1 on post 100', 1),
  ('c8', 100, NULL, 'second root c8 on post 100', 8),
  ('c6', 200, NULL, 'root c6 on post 200', 6);

INSERT INTO comments (id, post_id, parent_id, body, sort_order) VALUES
  ('c2', 100, 'c1', 'reply c2 to c1', 2),
  ('c3', 100, 'c1', 'reply c3 to c1', 3),
  ('c7', 200, 'c6', 'reply c7 to c6', 7);

INSERT INTO comments (id, post_id, parent_id, body, sort_order) VALUES
  ('c4', 100, 'c2', 'reply c4 to c2', 4),
  ('c5', 100, 'c4', 'reply c5 to c4', 5);

