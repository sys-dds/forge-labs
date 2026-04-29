CREATE VIEW c1_depth_and_path AS
SELECT id, depth, path FROM c1_recursive_thread ORDER BY path;

