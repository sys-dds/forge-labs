# Evidence Map

| Item | Exists because | Used by proof | Used by debug trace | Used by drill |
|---|---|---|---|---|
| 101 Ben followed backend post | proves followed_author retrieval | Proof asserts 101 source is followed_author | Debug trace must mention 101 kept by followed_author | Drill changes followed source collection |
| 201 Cy muted backend post | proves retrieval eligibility removes muted authors | Proof asserts 201 rejected muted_author | Debug trace must mention 201 rejected muted_author | Drill changes muted eligibility |
| 301 Noor blocked post | proves blocked authors are excluded before ranking | Proof asserts 301 rejected blocked_author | Debug trace must mention 301 rejected blocked_author | Drill changes block eligibility |
| 401 Diya group backend post | proves group source contributes candidates | Proof asserts 401 source group | Debug trace must mention 401 kept by group | Drill changes group source |
| 501 Lina semantic backend post | proves semantic source contributes meaning match | Proof asserts 501 source semantic_similarity | Debug trace must mention 501 kept by semantic_similarity | Drill changes semantic source |
| 601 Maya exploration post | proves exploration source backfills candidate pool | Proof asserts 601 source exploration | Debug trace must mention 601 kept by exploration | Drill changes exploration source |
| 701 Omar sports post | proves missed rows have retrieval reasons | Proof asserts 701 no_retrieval_source | Debug trace must mention 701 missed no_retrieval_source | Drill changes miss reason |
| 801 Theo unsafe post | proves unsafe content is rejected before ranking | Proof asserts 801 unsafe_content | Debug trace must mention 801 rejected unsafe_content | Drill changes safety eligibility |
| 901 Ivy cold-start post | proves fresh cold-start exploration is included | Proof asserts 901 source exploration | Debug trace must mention 901 kept by exploration | Drill changes cold-start exploration |
