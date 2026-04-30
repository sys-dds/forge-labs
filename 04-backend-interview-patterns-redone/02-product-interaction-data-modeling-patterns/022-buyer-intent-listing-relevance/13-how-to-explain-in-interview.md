# How To Explain In Interview

## Direct answer

Model design buyer intent and listing relevance for a marketplace search/feed. with `buyers`, `buyer_intents`, `sellers`, `listings`, `listing_tags`, `listing_availability`, `seller_trust_components`, `buyer_seen_listings`, then prove the read contract from source rows instead of a memorised answer.

## Actual tables

Use `buyers`, `buyer_intents`, `sellers`, `listings`, `listing_tags`, `listing_availability`, `seller_trust_components`, `buyer_seen_listings` in schema `bip_pim_022`.

## Actual trap rows

Ada wants cleaning under 120 in North, listing 101 matches category price location and availability, listing 102 is already seen, listing 103 has a low-trust seller, and listing 104 is the wrong category. Ada is the buyer/viewer row used when the clinic needs a named person to test the read contract.

## Exact query mechanics

Join `buyer_intents` to listings and availability, derive category/price/location/availability components, join seller trust components, and emit relevance_debug_trace.

## Write path

Write buyer intent, listing tags, availability windows, seller trust components, and seen rows independently before reading relevance.

## Marketplace/product follow-up

Ask which component explains a selected listing and which component suppresses a listing.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached marketplace read models.
