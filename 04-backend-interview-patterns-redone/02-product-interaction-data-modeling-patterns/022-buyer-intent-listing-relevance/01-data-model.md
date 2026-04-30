# Data Model

## Actual tables

`buyers`, `buyer_intents`, `sellers`, `listings`, `listing_tags`, `listing_availability`, `seller_trust_components`, `buyer_seen_listings`

## Trap rows

Ada wants cleaning under 120 in North, listing 101 matches category price location and availability, listing 102 is already seen, listing 103 has a low-trust seller, and listing 104 is the wrong category.

## Constraints

Use source rows for lifecycle and component math. Do not collapse the model into one opaque marketplace score, one static popularity rank, or one boolean trust flag.
