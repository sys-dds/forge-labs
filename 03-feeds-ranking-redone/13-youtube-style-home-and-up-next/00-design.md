# Design

## What this clinic teaches

Home and Up Next are different video surfaces.

## Product surface and user intent

Home starts a broad session; Up Next continues the video Ada just watched.

## Named users/content and why each exists

- Item: 101
- Why it exists: current video anchors Up Next
- Simulation/proof that uses it: Proof asserts Up Next relates to 101
- Wrong behavior if removed: Session context vanishes
- Item: 201
- Why it exists: related testing video
- Simulation/proof that uses it: Proof asserts 201 first Up Next
- Wrong behavior if removed: Continuation fails
- Item: 301
- Why it exists: home interest video
- Simulation/proof that uses it: Proof asserts 301 first Home
- Wrong behavior if removed: Home loses interest mix
- Item: 401
- Why it exists: dragon home interest
- Simulation/proof that uses it: Proof asserts 401 Home
- Wrong behavior if removed: Home loses variety
- Item: 501
- Why it exists: clickbait abandonment
- Simulation/proof that uses it: Proof asserts 501 rejected
- Wrong behavior if removed: Clickbait wins
- Item: 601
- Why it exists: blocked creator
- Simulation/proof that uses it: Proof asserts 601 blocked_author
- Wrong behavior if removed: Blocked video leaks
- Item: 701
- Why it exists: unrelated football
- Simulation/proof that uses it: Proof asserts 701 no relevance
- Wrong behavior if removed: Unrelated item leaks
- Item: 801
- Why it exists: advanced related Java
- Simulation/proof that uses it: Proof asserts 801 Up Next
- Wrong behavior if removed: Related depth lost
- Item: 901
- Why it exists: new creator Java tip
- Simulation/proof that uses it: Proof asserts 901 exploration
- Wrong behavior if removed: Exploration lost

## Broken ranking behavior

The broken simulation uses click ranking for both surfaces and leaks blocked/clickbait rows.

## Exact wrong result from the broken version

The broken output puts Omar 501 and Noor 601 into the same Home and Up Next list.

## Correct result from the solution

home [301,401,901,201], up_next [201,801,901]

## Proof assertions

The proof checks exact Home, exact Up Next, rejected items, exploration, and traces.

## Beginner mental model

Home asks what starts a session; Up Next asks what continues this session.

## What the learner should notice

The same video can be right for Home but wrong for Up Next.

## Interview explanation target

Explain current-video context, abandonment filtering, and exploration separately.
