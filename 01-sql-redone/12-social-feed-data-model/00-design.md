# Design

## What this clinic teaches

Social feed tables separate authored posts, child facts, graph edges, group membership, visibility, and author safety filters.

## Named rows and why each exists

- Row: Ben post 101 public.
  Why it exists: proves a followed author's public post survives.
  Query/proof that uses it: `ada_visible_social_posts` exact output and count assertions.
  Wrong behavior if removed: comment/reaction/repost aggregation cannot be proven.
- Row: Ben post 102 followers-only.
  Why it exists: proves follows can satisfy visibility.
  Query/proof that uses it: exact visible post set.
  Wrong behavior if removed: followers-only visibility is untested.
- Row: Cy post 201.
  Why it exists: proves muted authors are excluded.
  Query/proof that uses it: muted exclusion assertion.
  Wrong behavior if removed: mute predicate can be deleted unnoticed.
- Row: Noor post 301.
  Why it exists: proves blocked authors are excluded.
  Query/proof that uses it: block exclusion assertion.
  Wrong behavior if removed: block predicate can be deleted unnoticed.
- Row: Diya post 401 in Backend Club.
  Why it exists: proves group membership creates eligibility.
  Query/proof that uses it: exact visible post set and reason assertion.
  Wrong behavior if removed: group visibility branch is untested.
- Row: Lina post 601 in Design Club.
  Why it exists: proves wrong-group posts are excluded.
  Query/proof that uses it: wrong-group exclusion assertion.
  Wrong behavior if removed: group membership bugs are invisible.
- Row: Ben post 103 hidden.
  Why it exists: proves hidden/deleted filtering.
  Query/proof that uses it: hidden exclusion assertion.
  Wrong behavior if removed: deleted content filter is untested.
- Row: Noor comment on Ben post 101.
  Why it exists: proves blocked child actor does not remove Ben's post in this clinic.
  Query/proof that uses it: Ben 101 count assertion.
  Wrong behavior if removed: child actor versus author eligibility is less clear.

## Broken query bug

The broken query treats public/group posts too broadly, misses follower/group visibility rules, includes muted/blocked/hidden/wrong-group posts, and multiplies Ben 101 through child joins.

## Exact wrong result from the broken query

Ada's feed includes Cy 201, Noor 301, Omar 501, Lina 601, and Ben 103, misses or mislabels valid paths, and duplicates/inflates Ben 101 counts.

## Correct result from the solution

Ada sees Ben 101, Ben 102, and Diya 401 with exact reasons and child counts.

## Proof assertions

The proof checks exact post ids/reasons, exclusion rows, Ben 101 counts, no duplicate posts, and that Cy/Noor child activity does not remove Ben 101.

## What the learner should notice

Eligibility is about the post author and visibility path; comments, reactions, and reposts are child facts that should be aggregated separately.

## Interview explanation target

Explain the base social data model, visibility filtering, child fact aggregation, graph eligibility, author eligibility versus child actor activity, and data model versus ranking.

