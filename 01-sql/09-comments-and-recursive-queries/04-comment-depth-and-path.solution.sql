-- Depth supports indentation. Path supports stable tree ordering.
CREATE VIEW comment_depth_and_path AS SELECT id, depth, path FROM recursive_thread;
