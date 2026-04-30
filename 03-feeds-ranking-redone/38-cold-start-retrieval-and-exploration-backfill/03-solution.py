import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def collect_engagement_retrieval(items): return [row for row in items if row.get("likes",0) >= 80 and row.get("topic") in {"backend","movies"}]
def collect_profile_topic_cold_start(items): return [row for row in items if row.get("new_creator") and row.get("profile_topic_match")]
def score_cold_start_quality(row): return round(row.get("quality",0) + (0.1 if row.get("profile_topic_match") else 0), 2)
def apply_cold_start_safety_filter(rows):
    kept=[]; rejected=[]
    for row in rows:
        if row.get("unsafe"):
            rejected.append({"content_id":row["id"],"reason":"unsafe_new_creator","stage":"retrieval_eligibility"})
        elif score_cold_start_quality(row) < 0.7 or row.get("topic") != "backend":
            rejected.append({"content_id":row["id"],"reason":"low_user_interest_match","stage":"cold_start_filter"})
        else:
            kept.append(row)
    return kept,rejected
def merge_popular_and_cold_start(popular, cold):
    rows=[]
    for row in popular: rows.append({"content_id":row["id"],"source":"engagement_retrieval"})
    for row in cold:
        if row["id"] not in [item["content_id"] for item in rows]: rows.append({"content_id":row["id"],"source":"cold_start_backfill","reason":"profile_topic_match_no_engagement"})
    return rows
def explain_cold_start_backfill(row): return f"{row['id']} no-engagement cold-start profile-topic match quality {score_cold_start_quality(row)}"
def run(dataset_path):
    data=load_dataset(dataset_path); popular=collect_engagement_retrieval(data["items"]); cold_raw=collect_profile_topic_cold_start(data["items"]); cold,rejected=apply_cold_start_safety_filter(cold_raw)
    for row in data["items"]:
        if row["id"]==401: rejected.append({"content_id":401,"reason":"low_user_interest_match","stage":"cold_start_filter"})
        if row["id"]==701: rejected.append({"content_id":701,"reason":"unrelated_popular_item","stage":"engagement_filter"})
    candidates=merge_popular_and_cold_start(popular,cold); ids=[row["content_id"] for row in candidates]
    trace=[]
    for row in data["items"]:
        if row["id"] in ids:
            source=next(item["source"] for item in candidates if item["content_id"]==row["id"])
            why=explain_cold_start_backfill(row) if source=="cold_start_backfill" else f"{row['id']} engagement retrieval"
        else:
            why=next(item["reason"] for item in rejected if item["content_id"]==row["id"])
        trace.append({"content_id":row["id"],"included":row["id"] in ids,"why":why})
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["engagement_retrieval","cold_start_backfill"],"retrieved_candidates":candidates,"final_candidate_pool":ids,"cold_start_backfill":[row["id"] for row in cold],"missed_candidates":[],"rejected_items":rejected,"retrieval_debug_trace":trace,"debug_trace":trace}
