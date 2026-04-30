# How To Explain In Interview

## Direct answer

Model design seller quality ranking using fulfilment history, response behaviour, cancellations, disputes, and reviews. with `sellers`, `listings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_quality_snapshots`, then prove the read contract from source rows instead of a memorised answer.

## Actual tables

Use `sellers`, `listings`, `orders`, `seller_response_events`, `seller_reviews`, `disputes`, `seller_quality_components`, `seller_quality_snapshots` in schema `bip_pim_023`.

## Actual trap rows

Ada sees BrightSeller boosted from fulfilled orders, quick responses, and reviews, while RiskSeller is reviewed after cancellation and dispute components. Ada is the buyer/viewer row used when the clinic needs a named person to test the read contract.

## Exact query mechanics

Sum `seller_quality_components`, keep the named component rows visible, and compare the snapshot treatment with source fulfilment, response, review, cancellation, and dispute evidence.

## Write path

Write orders, responses, reviews, disputes, component rows, and the seller quality snapshot as separate rows.

## Marketplace/product follow-up

Ask which seller component changed the treatment and whether the snapshot can be recomputed from source rows.

## Scaling follow-up

First keep the debug trace reproducible from source rows; only then introduce cached marketplace read models.
