# Model Answer

I would anchor the recursive CTE at post `100` root comments, then recursively join children whose `parent_id` equals the previous level's comment id. I would carry `depth` and a padded path so `c1, c2, c4, c5, c3` renders predictably and post `200` comments never enter.
