# Model Answer

I would start from Ada's row, join `follows.follower_id` to Ada, join the followee to authors, then join posts by `posts.author_id`. Ben posts survive. Cy is removed by the mute anti-join, Noor by the block anti-join, and Diya never appears because Ada does not follow her.
