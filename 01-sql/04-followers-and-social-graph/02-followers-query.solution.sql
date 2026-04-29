-- Followers of Ada are rows where Ada is the followee.
CREATE VIEW ada_followers AS SELECT u.handle FROM follows f JOIN users u ON u.id=f.follower_id WHERE f.followee_id=1 ORDER BY u.handle;
