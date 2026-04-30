# Model Answer

For latest post per author I would use `ROW_NUMBER() OVER (PARTITION BY author ORDER BY created_at DESC, id DESC)`. Ada's tied latest posts use id as the tie-breaker. For engagement labels I would choose `RANK` when gaps matter and `DENSE_RANK` when they do not.
