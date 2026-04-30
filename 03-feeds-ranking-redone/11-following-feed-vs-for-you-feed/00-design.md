# Design

## What this clinic teaches

following feed and For You feed

## Product surface and user intent

Following is mostly chronological followed content; For You mixes recommendations and exploration.

## Named users/content and why each exists

- Item: 101
- Why it exists: Ben proves followed recent content survives
- Simulation/proof that uses it: Proof asserts 101 appears in both surfaces
- Wrong behavior if removed: Following loses a valid followed post
- Item: 102
- Why it exists: Ben older post proves chronological following still includes older followed content
- Simulation/proof that uses it: Proof asserts 102 remains in both surfaces
- Wrong behavior if removed: Following looks too much like For You
- Item: 201
- Why it exists: Cy proves muted followed content is rejected
- Simulation/proof that uses it: Proof asserts 201 muted_author
- Wrong behavior if removed: Muted content leaks
- Item: 301
- Why it exists: Noor proves blocked content is rejected
- Simulation/proof that uses it: Proof asserts 301 blocked_author
- Wrong behavior if removed: Blocked content leaks
- Item: 401
- Why it exists: Diya proves another followed author survives
- Simulation/proof that uses it: Proof asserts 401 in both outputs
- Wrong behavior if removed: Following lacks followed diversity
- Item: 501
- Why it exists: Lina proves For You can include out-of-network
- Simulation/proof that uses it: Proof asserts 501 in For You and not Following
- Wrong behavior if removed: For You becomes only following
- Item: 701
- Why it exists: Maya proves exploration in For You
- Simulation/proof that uses it: Proof asserts 701 in For You
- Wrong behavior if removed: Exploration disappears
- Item: 801
- Why it exists: Omar proves unsafe hard exclusion
- Simulation/proof that uses it: Proof asserts 801 unsafe_content
- Wrong behavior if removed: Unsafe content leaks

## Broken ranking behavior

Broken uses one output for both surfaces and leaks excluded items.

## Exact wrong result from the broken version

following_feed and for_you_feed both contain unsafe or out-of-network wrong rows.

## Correct result from the solution

following_feed [101,401,102], for_you_feed [101,501,401,701,102].

## Proof assertions

Exact surfaces, rejections, surface-specific traces, and out-of-network checks.

## Beginner mental model

Following asks who Ada follows; For You asks what Ada may like.

## What the learner should notice

One universal ranker is wrong for different surfaces.

## Interview explanation target

Explain surface intent before ranking math.
