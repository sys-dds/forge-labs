# Debugging Notes

Ada follows Ben, so Ben's visible post 201 is not enough to make Ben a suggestion. The already-followed exclusion removes Ben before ranking.

Ben follows Diya, Maya, Lina, and Omar. Diya, Maya, and Lina become graph candidates, but Omar has only hidden post 701, so Omar lacks visible signal.

Cy has visible post 301, but Ada blocks Cy. The block predicate must run before ordering, otherwise Cy can look attractive to ranking.

Noor has visible post 501 and follows Ben, but Noor's profile is not searchable. The endpoint must not expose Noor just because a row exists.

Diya has visible posts 401 and 402 plus followers Ben, Maya, and Omar. Joining posts and followers directly creates six Diya rows; isolated counts keep follower_count at 3 and post count at 2.

Lina and Maya each have one visible post, two followers, and the same latest timestamp. Lina's creator_id 9 sorts before Maya's creator_id 6 because the endpoint includes a stable id tie-breaker.

Theo is disconnected. If Theo appears, the query is browsing users instead of using Ada's graph candidates.

