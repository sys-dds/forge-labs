-- A self join compares rows in the same table; here it finds pairs of posts by the same author.
CREATE VIEW self_join_same_author_posts AS SELECT a.id AS first_post_id, b.id AS second_post_id FROM posts a JOIN posts b ON b.author_id=a.author_id AND b.id>a.id;
