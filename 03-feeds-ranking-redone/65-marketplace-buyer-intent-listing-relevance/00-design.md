# Design

## What this clinic teaches
Marketplace buyer intent and listing relevance teaches buyer intent and listing relevance using row-derived decisions.

## Creator/marketplace problem and user impact
Ada should see useful creator posts and marketplace listings without letting raw engagement, cheap price, or old popularity overwhelm quality, trust, fairness, local availability, and risk.

## Named viewers/buyers/creators/sellers/listings and why each exists
- Item: listing_101
- Why it exists: proves buyer intent and listing relevance with a named row.
- Simulation/proof that uses it: buyer_intent_rows prove category location budget and availability determine listing relevance
- Wrong behavior if removed: the proof can no longer distinguish the broken shortcut from the ecosystem rule.
- Item: listing_201
- Why it exists: proves buyer intent and listing relevance with a named row.
- Simulation/proof that uses it: buyer_intent_rows prove category location budget and availability determine listing relevance
- Wrong behavior if removed: the proof can no longer distinguish the broken shortcut from the ecosystem rule.
- Item: listing_301
- Why it exists: proves buyer intent and listing relevance with a named row.
- Simulation/proof that uses it: buyer_intent_rows prove category location budget and availability determine listing relevance
- Wrong behavior if removed: the proof can no longer distinguish the broken shortcut from the ecosystem rule.
- Item: listing_401
- Why it exists: proves buyer intent and listing relevance with a named row.
- Simulation/proof that uses it: buyer_intent_rows prove category location budget and availability determine listing relevance
- Wrong behavior if removed: the proof can no longer distinguish the broken shortcut from the ecosystem rule.
- Item: listing_501
- Why it exists: proves buyer intent and listing relevance with a named row.
- Simulation/proof that uses it: buyer_intent_rows prove category location budget and availability determine listing relevance
- Wrong behavior if removed: the proof can no longer distinguish the broken shortcut from the ecosystem rule.

## Broken ecosystem/ranking behavior
listing_401, listing_301, listing_501 from cheapest price, including wrong category and city.

## Exact wrong result from the broken version
listing_401, listing_301, listing_501 from cheapest price, including wrong category and city.

## Correct result from the solution
listing_101, listing_201, listing_501 from intent match, with Noor blocked and wrong city/category/over budget excluded.

## Proof assertions
buyer_intent_rows prove category location budget and availability determine listing relevance with exact outputs, rejected rows, treatment rows, and trace text.

## Beginner mental model
Rank the row only after asking what Ada wants, which supply is eligible, which provider is trusted, and which exposure or risk treatment applies.

## Senior engineering review angle
Review score components, treatment stages, and handoff traces before discussing weight tuning.

## What the learner should notice
The winning item is not always the most popular or cheapest item; it is the item that survives ecosystem constraints with explainable evidence.

## Interview explanation target
Explain marketplace ranking as buyer intent parsing before seller trust or price optimization.
