# Debugging Notes

c1 is the base case. If the base starts at every root, c8 from post 100 and c6 from post 200 enter the result before recursion even begins.

c2 and c3 are direct children of c1. The direct replies query should return those two rows and nothing from post 200.

c4 and c5 prove the recursive term is walking descendants, not just direct replies. c4 should be depth 2 and c5 should be depth 3.

c8 is a valid root comment on post 100, but it is not inside c1's subtree. Its presence means the base case is too broad.

c6 and c7 belong to post 200. Their presence means the query lost post scope and is no longer answering Ada's post 100 request.

Path ordering keeps c2, c4, and c5 together before c3. Ordering only by id or creation time can separate a child from its parent chain.

