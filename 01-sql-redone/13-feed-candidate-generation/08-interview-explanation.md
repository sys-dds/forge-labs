# Interview Explanation

## Direct answer

I would generate feed candidates from multiple recall sources, attach a reason and source actor, apply safety exclusions, then pass the result to ranking.

## Dataset walkthrough

Ada follows Ben, Cy, and Diya. Ben 101 comes from followed_author. Maya 301 comes from Backend Club. Lina 601 and 602 come from Diya's like and repost. Cy 201 is muted, Noor 701 is blocked, and Omar 801 and Theo 901 have no path.

## Query reasoning

The solution unions followed-author, shared-group, liked-by-following, and reposted-by-following branches. It then removes candidates whose authors Ada muted or blocked and returns author, reason, source actor, and creation time.

## Common mistake

The common mistake is ranking followed-author posts only. That misses Maya 301 and Lina 601/602 before ranking gets a chance to score them.

## Senior trade-off

Keeping candidate_reason in the output is useful for debugging even if the production endpoint later hides it from users.

## Follow-up answer

If ranking is added later, I would keep this candidate query as the recall stage and score only the safe candidate rows it emits.

