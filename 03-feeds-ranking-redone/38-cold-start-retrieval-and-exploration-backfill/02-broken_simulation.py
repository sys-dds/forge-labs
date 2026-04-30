import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def collect_engagement_retrieval(items): return sorted(items, key=lambda row:-row.get("likes",0))[:4]
def collect_profile_topic_cold_start(items): return []
def score_cold_start_quality(row): return 0
def apply_cold_start_safety_filter(rows): return rows, []
def merge_popular_and_cold_start(popular,cold): return [{"content_id":row["id"],"source":"engagement_retrieval"} for row in popular+cold]
def explain_cold_start_backfill(row): return "popular"
def run(dataset_path):
    data=load_dataset(dataset_path); candidates=merge_popular_and_cold_start(collect_engagement_retrieval(data["items"]),[]); ids=[row["content_id"] for row in candidates]
    trace=[{"content_id":row["id"],"included":row["id"] in ids,"why":"popular engagement only"} for row in data["items"]]
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["engagement_retrieval"],"retrieved_candidates":candidates,"final_candidate_pool":ids,"cold_start_backfill":[],"missed_candidates":[],"rejected_items":[],"retrieval_debug_trace":trace,"debug_trace":trace}
