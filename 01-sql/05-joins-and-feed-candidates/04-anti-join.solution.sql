-- Anti joins ask what is not present. This excludes blocked authors from the candidate set.
CREATE VIEW anti_join_not_blocked AS SELECT p.id FROM posts p WHERE NOT EXISTS (SELECT 1 FROM blocks b WHERE b.blocker_id=1 AND b.blocked_id=p.author_id);
