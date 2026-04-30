# Scaling Notes

Start with source correctness. Materialize marketplace read models only after the source-derived contract is stable and replayable from `sellers`, `listings`, `orders`, `seller_response_events`.
