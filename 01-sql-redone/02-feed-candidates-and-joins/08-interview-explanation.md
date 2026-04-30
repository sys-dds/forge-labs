# Interview Explanation

## Direct answer

I would first build the feed candidate set from Ada to followed authors to visible posts, then apply mute and block anti-joins, then join aggregated likes and comments.

## Dataset walkthrough

Ada follows Ben, Cy, and Noor. Ben post 102 and Ben post 101 survive. Cy post 201 is removed by the mute row. Noor post 301 is removed by the block row. Diya post 401 is never reached because Ada does not follow Diya. Ben post 103 is removed by `is_hidden = false`.

## Query reasoning

The solution builds candidate posts through Ada's outgoing follows, filters hidden content, uses anti-joins for mutes and blocks, then left joins separate like and comment summaries.

## Common mistake

The common mistake is treating mutes and blocks as ranking signals. They are eligibility filters; if Cy post 201 reaches ranking, the candidate query already failed.

## Senior trade-off

Separate aggregation is a little more verbose than raw joins, but it keeps the output grain at one row per post. That makes counts and ranking inputs easier to reason about.

## Follow-up answer

If ranking were added later, I would feed only Ben post 102 and Ben post 101 into it; I would not let ranking decide whether Cy post 201 or Noor post 301 is safe.
