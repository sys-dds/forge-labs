# Break Fix Drills

1. Remove the mute `NOT EXISTS`; Cy post 201 should appear in Ada's feed even though Ada muted Cy.
2. Remove the block `NOT EXISTS`; Noor post 301 should appear through the follow join even though Ada blocked Noor.
3. Change the comment summary join to an inner join; Ben post 102 should disappear because it has zero comments.
4. Remove `p.is_hidden = false`; Ben post 103 should appear as the newest Ben row.
5. Count likes after joining raw comments; Ben post 101 should report 6 likes instead of 2.

