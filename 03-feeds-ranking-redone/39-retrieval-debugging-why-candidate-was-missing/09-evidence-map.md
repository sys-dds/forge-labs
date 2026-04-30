# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 followed source | kept retrieval control | Proof asserts final pool includes 101 | Debug trace must mention 101 followed source | Drill changes followed source |
| 201 semantic source | kept semantic control | Proof asserts final pool includes 201 | Debug trace must mention 201 semantic source | Drill changes semantic source |
| 301 not indexed yet | index freshness miss | Proof asserts index_not_fresh | Debug trace must mention 301 index_not_fresh | Drill changes index freshness |
| 401 embedding version mismatch | embedding drift miss | Proof asserts embedding_version_mismatch | Debug trace must mention 401 embedding_version_mismatch | Drill changes embedding version |
| 501 retrieval eligibility filtered | eligibility miss | Proof asserts retrieval_eligibility_filtered | Debug trace must mention 501 retrieval_eligibility_filtered | Drill changes eligibility |
| 601 source quota overflow | quota miss | Proof asserts source_quota_overflow | Debug trace must mention 601 source_quota_overflow | Drill changes quota |
| 701 lexical tokenization miss | tokenization miss | Proof asserts lexical_tokenization_miss | Debug trace must mention 701 lexical_tokenization_miss | Drill changes tokenization |
| 801 ANN bucket not probed | ANN probe miss | Proof asserts ann_bucket_not_probed | Debug trace must mention 801 ann_bucket_not_probed | Drill changes ANN probe |
| 901 exploration fallback | kept fallback retrieval | Proof asserts final pool includes 901 | Debug trace must mention 901 exploration fallback | Drill changes exploration fallback |
