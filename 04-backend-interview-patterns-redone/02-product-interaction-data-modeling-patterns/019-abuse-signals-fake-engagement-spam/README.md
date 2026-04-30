# 019 Abuse Signals Fake Engagement Spam

Design abuse signals for spam, fake engagement, repeated comments, fake likes, and suspicious interaction bursts.

Schema `bip_pim_019` named rows: Cy user 3 repeats duplicate comments 301/302/303 creating spam signal 7001, Ben user 2 has like burst signal 7002 on post 201, Diya user 4 has normal engagement and no signal, report 6001 plus evidence rows 8001 and 8002 put Cy into review, and treatment 9001 reviews Cy while treatment 9002 allows Diya.

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/019-abuse-signals-fake-engagement-spam`.
