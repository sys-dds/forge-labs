# Interview Explanation

Window functions do not reduce rows; they label rows. I would use `ROW_NUMBER` per author for latest posts, `RANK` and `DENSE_RANK` deliberately for tie behavior, and partition running totals by author.
