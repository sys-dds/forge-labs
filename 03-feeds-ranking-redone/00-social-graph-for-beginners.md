# Social Graph For Beginners

## node
Plain-English meaning: a thing in the graph, such as Ada, Ben, `post_101`, or `backend_club`.
Tiny example from clinics 41-50: clinic 41 has user, group, and content nodes.
Common beginner mistake: treating all nodes as if they can be recommended the same way.
How to debug it: print node type beside the candidate ID.
What a senior engineer asks next: which node types are allowed on this surface?

## edge
Plain-English meaning: a relationship between nodes.
Tiny example from clinics 41-50: `ada -> ben` is a follow edge and `ben -> post_101` is an authored edge.
Common beginner mistake: ignoring the edge label.
How to debug it: log `from`, `to`, and `type` for each path.
What a senior engineer asks next: which edge types are trusted enough for candidate generation?

## directed edge
Plain-English meaning: an edge with a direction; Ada following Ben does not mean Ben follows Ada.
Tiny example from clinics 41-50: clinic 41 uses directed follow edges to reach `post_101`.
Common beginner mistake: treating a follow edge as a friendship.
How to debug it: compare outgoing and incoming neighbors separately.
What a senior engineer asks next: is reverse traversal allowed for this product surface?

## undirected edge
Plain-English meaning: a relationship that works both ways, such as a friendship.
Tiny example from clinics 41-50: clinic 41 builds separate friend rows for Ada and Diya.
Common beginner mistake: mixing friendship and follow semantics.
How to debug it: print the expanded pair rows.
What a senior engineer asks next: are privacy rules symmetric too?

## edge type
Plain-English meaning: the label that says what the edge means.
Tiny example from clinics 41-50: follow, mute, block, member, authored.
Common beginner mistake: counting a block edge as interest.
How to debug it: sample paths and inspect edge labels.
What a senior engineer asks next: which edge types are hard exclusions?

## follow graph
Plain-English meaning: people or creators a viewer follows.
Tiny example from clinics 41-50: Ada follows Ben and can see Ben's `post_101`.
Common beginner mistake: using followed content after the author is muted or blocked.
How to debug it: join follow paths with block/mute edges.
What a senior engineer asks next: how fresh is the follow edge?

## friend graph
Plain-English meaning: social connections used for mutuals and triangle closing.
Tiny example from clinics 41-50: Maya is suggested through Ben and Diya in clinic 42.
Common beginner mistake: ranking mutuals without counting the mutual people.
How to debug it: log each mutual path.
What a senior engineer asks next: are blocked paths removed before scoring?

## mutual friend
Plain-English meaning: a person connected to both Ada and a candidate.
Tiny example from clinics 41-50: Maya has mutuals Ben and Diya.
Common beginner mistake: saying "mutual" without listing who the mutuals are.
How to debug it: print `candidate_id`, `mutual_count`, and `mutuals`.
What a senior engineer asks next: should one strong mutual beat two weak mutuals?

## triangle closing
Plain-English meaning: recommending a new connection to complete Ada-Ben-Maya-Ada style triangles.
Tiny example from clinics 41-50: Ada -> Ben -> Maya creates one path; Ada -> Diya -> Maya creates another.
Common beginner mistake: recommending anyone at distance two even after blocks.
How to debug it: show the two-hop paths and exclusions.
What a senior engineer asks next: is the triangle evidence recent and trusted?
