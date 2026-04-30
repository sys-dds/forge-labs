# Model Answer

For swipes, `(swiper_id, swiped_id)` should be the primary key so Ada cannot LIKE Ben and later PASS Ben as a second row. A `CHECK (swiper_id <> swiped_id)` rejects self-swipes before application code has to interpret them.
