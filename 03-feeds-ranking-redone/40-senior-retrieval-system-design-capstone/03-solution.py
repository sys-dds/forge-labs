import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def build_source_registry():
    return [
        {"name":"followed_author","purpose":"keep explicit social intent","failure_mode":"follow graph lag"},
        {"name":"lexical","purpose":"exact query/topic token match","failure_mode":"tokenization miss"},
        {"name":"semantic","purpose":"meaning match by embedding","failure_mode":"embedding drift"},
        {"name":"two_tower","purpose":"user-item embedding retrieval","failure_mode":"user vector stale"},
        {"name":"ann","purpose":"fast approximate vector lookup","failure_mode":"bucket not probed"},
        {"name":"cold_start_backfill","purpose":"new high-quality creator coverage","failure_mode":"quality signal sparse"},
    ]
def run_lexical_retrieval(items): return [row for row in items if row.get("source")=="lexical"]
def run_semantic_retrieval(items): return [row for row in items if row.get("source")=="semantic" and row.get("index_fresh", True)]
def run_two_tower_retrieval(items): return [row for row in items if row.get("source")=="two_tower"]
def run_ann_retrieval(items): return [row for row in items if row.get("source")=="ann" and row.get("ann_bucket_probed", True)]
def run_cold_start_backfill(items): return [row for row in items if row.get("source")=="cold_start_backfill"]
def apply_retrieval_safety(rows):
    kept=[]; rejected=[]
    for row in rows:
        if row.get("blocked"):
            rejected.append({"content_id":row["id"],"reason":"blocked_author","stage":"retrieval_eligibility"})
        elif row.get("unsafe"):
            rejected.append({"content_id":row["id"],"reason":"unsafe_content","stage":"retrieval_eligibility"})
        else:
            kept.append(row)
    return kept,rejected
def blend_retrieval_sources(items):
    rows=[]
    for source_fn in [lambda value:[row for row in value if row.get("source")=="followed_author"], run_lexical_retrieval, run_semantic_retrieval, run_two_tower_retrieval, run_ann_retrieval, run_cold_start_backfill]:
        rows.extend(source_fn(items))
    kept,rejected=apply_retrieval_safety(rows)
    seen_rejected = {row["content_id"] for row in rejected}
    for row in items:
        if row.get("blocked") and row["id"] not in seen_rejected:
            rejected.append({"content_id":row["id"],"reason":"blocked_author","stage":"retrieval_eligibility"})
            seen_rejected.add(row["id"])
        elif row.get("unsafe") and row["id"] not in seen_rejected:
            rejected.append({"content_id":row["id"],"reason":"unsafe_content","stage":"retrieval_eligibility"})
            seen_rejected.add(row["id"])
    priority={"followed_author":1,"lexical":2,"semantic":3,"two_tower":4,"ann":5,"cold_start_backfill":6}
    ordered=sorted(kept,key=lambda row:(priority[row["source"]], row["id"]))
    return ordered,rejected
def build_missing_candidate_explanations(items):
    explanations=[]
    for row in items:
        if row.get("index_fresh") is False:
            explanations.append({"content_id":row["id"],"reason":"index_not_fresh","stage":"retrieval"})
        if row.get("ann_bucket_probed") is False:
            explanations.append({"content_id":row["id"],"reason":"ann_bucket_not_probed","stage":"retrieval"})
    return explanations
def build_retrieval_system_design():
    return {"source_registry":build_source_registry(),"index_freshness_policy":{"max_lag_minutes":10,"checks":["index_generation","document_count_delta"],"failure_action":"exclude_stale_index_rows"},"embedding_version_policy":{"required_version":"v3","compatibility":"user_and_item_versions_must_match"},"source_blending_policy":{"quotas":{"followed_author":1,"lexical":1,"semantic":1,"two_tower":1,"ann":1,"cold_start_backfill":1}},"evaluation_policy":{"metrics":["recall","precision","offline_replay"],"first_stage_priority":"protect_recall"},"debugging_policy":{"missing_candidate_explanations":["index_not_fresh","ann_bucket_not_probed","retrieval_eligibility_filtered"]},"ranking_handoff_contract":{"fields":["candidate_ids","sources","scores","traces"]}}
def build_ranking_handoff_contract(candidates, trace):
    trace_by_id={row["content_id"]:row["why"] for row in trace}
    return [{"content_id":row["id"],"source":row["source"],"score":row.get("score"),"trace":trace_by_id[row["id"]]} for row in candidates]
def run(dataset_path):
    data=load_dataset(dataset_path); candidates,rejected=blend_retrieval_sources(data["items"]); missing=build_missing_candidate_explanations(data["items"]); ids=[row["id"] for row in candidates]
    trace=[]
    for row in data["items"]:
        if row["id"] in ids: why=f"{row['id']} retrieved by {row['source']} score {row.get('score')}"
        elif row.get("blocked"): why=f"{row['id']} blocked_author"
        elif row.get("unsafe"): why=f"{row['id']} unsafe_content"
        elif row.get("index_fresh") is False: why=f"{row['id']} index_not_fresh"
        elif row.get("ann_bucket_probed") is False: why=f"{row['id']} ann_bucket_not_probed"
        else: why=f"{row['id']} not selected"
        trace.append({"content_id":row["id"],"included":row["id"] in ids,"why":why})
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":[row["name"] for row in build_source_registry()],"retrieved_candidates":[{"content_id":row["id"],"source":row["source"],"score":row.get("score")} for row in candidates],"final_candidate_pool":ids,"missing_candidate_explanations":missing,"missed_candidates":missing,"rejected_items":rejected,"retrieval_system_design":build_retrieval_system_design(),"ranking_handoff_contract":build_ranking_handoff_contract(candidates, trace),"retrieval_debug_trace":trace,"debug_trace":trace}
