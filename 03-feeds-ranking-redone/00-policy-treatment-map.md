# Policy Treatment Map

## remove
Meaning: hard filter the item. Example: post_201 spam_scam in clinic 51. Debug by checking rejected_items.

## reduce
Meaning: keep but lower distribution. Example: post_401 clickbait is downranked in clinic 51. Debug by checking downranked_items and penalty.

## inform
Meaning: keep with context. Example: post_501 receives a context label. Debug by checking informed_items.

## review
Meaning: route to review queue. Example: post_801 needs review in clinic 51. Debug by checking review_queue.

## allow
Meaning: safety permits ranking to continue. Example: post_101 safe backend post. Debug by checking safety_debug_trace still exists.
