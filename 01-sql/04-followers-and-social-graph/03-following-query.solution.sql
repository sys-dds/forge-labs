-- Following for Ada are rows where Ada is the follower.
CREATE VIEW ada_following AS SELECT u.handle FROM follows f JOIN users u ON u.id=f.followee_id WHERE f.follower_id=1 ORDER BY u.handle;
