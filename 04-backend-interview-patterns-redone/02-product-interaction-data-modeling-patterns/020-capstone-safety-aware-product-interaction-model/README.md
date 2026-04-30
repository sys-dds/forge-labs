# 020 Capstone Safety Aware Product Interaction Model

Design a safety-aware product interaction model that combines reports, review queues, policy decisions, treatments, appeals, trust components, abuse signals, and audit lineage.

Schema `bip_pim_020` named rows: safe post 201 remains visible, reported post 202 enters queue item 501 but treatment allow keeps it visible, confirmed post 203 gets remove treatment 703, creator 3 is downranked from component rows 1101/1102, approved appeal 901 restores post 204, rejected appeal 902 keeps post 205 removed, abuse signal 1001 has evidence rows 1201/1202, and audit rows 1301-1304 link report to decision to treatment to appeal. 

Run `./scripts/bip-pim-test-one.sh 04-backend-interview-patterns-redone/02-product-interaction-data-modeling-patterns/020-capstone-safety-aware-product-interaction-model`.
