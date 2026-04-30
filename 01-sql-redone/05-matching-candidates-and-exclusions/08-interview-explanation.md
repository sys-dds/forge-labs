# Interview Explanation

## Direct answer

I would separate mutual match detection from candidate generation. Mutual matches require two LIKE rows. Raw candidates remove self, inactive users, blocked users, and users Ada already swiped. Preference fit runs after that.

## Dataset walkthrough

Ben has Ada LIKE Ben and Ben LIKE Ada, so Ben is the only mutual match. Cy liked Ada, but Ada passed Cy, so Cy is excluded. Diya is blocked by Ada. Noor is inactive. Maya and Omar are raw candidates. Maya is the only preference-fit candidate and shares two interests with Ada.

## Common mistake

The common mistake is mixing PASS with LIKE or letting preference fit run before safety exclusions. That can make Cy look matched or Diya look eligible.

## Senior trade-off

I would keep exclusions explicit even if ranking later uses a scoring model. A ranker can sort safe candidates; it should not decide whether blocked or already-swiped users are safe to show.

