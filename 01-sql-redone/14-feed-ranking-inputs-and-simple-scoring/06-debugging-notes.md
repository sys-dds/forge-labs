# Debugging Notes

Ben post 101 has 2 likes and 3 comments. With comments weighted at 4 points, its engagement score is 16 and raw score is 31.

Ben post 102 has 5 likes and 1 comment. A likes-only query ranks it first, but the documented score puts it second with raw score 25.

Maya post 301 has shared_group affinity 6, one like, and two comments. Its raw score 21 shows group candidates can compete without being followed authors.

Lina post 601 has 4 likes but lower liked_by_following affinity 3 and zero comments, so its raw score is 16.

Lina post 602 proves reposted_by_following has its own affinity score and that Lina is a repeated author.

Ada's prior replies to Ben explain why followed-author affinity is high here, but the query still exposes the numeric feature columns instead of hiding them.

