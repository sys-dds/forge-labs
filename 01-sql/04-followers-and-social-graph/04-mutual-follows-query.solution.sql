-- Mutual follows are two directed edges that point at each other.
CREATE VIEW ada_mutual_follows AS SELECT u.handle FROM follows out_edge JOIN follows back_edge ON back_edge.follower_id=out_edge.followee_id AND back_edge.followee_id=out_edge.follower_id JOIN users u ON u.id=out_edge.followee_id WHERE out_edge.follower_id=1 ORDER BY u.handle;
