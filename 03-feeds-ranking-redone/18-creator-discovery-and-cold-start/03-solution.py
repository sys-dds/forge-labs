import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def score_creator_relevance(row): return row.get("relevance",0)
def score_creator_quality(row): return row.get("quality",0)
def score_creator_consistency(row): return 5
def apply_already_followed_filter(row): return not row.get("followed")
def apply_creator_safety_filter(row): return not row.get("blocked") and not row.get("reported")
def reserve_cold_start_creator_slots(rows): return [row for row in rows if row.get("cold_start")]
def creator_score(row): return score_creator_relevance(row)+score_creator_quality(row)+score_creator_consistency(row)
def rank_creator_discovery(rows): return [r["id"] for r in sorted(rows, key=lambda r:-creator_score(r))[:4]]
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if not apply_already_followed_filter(row): rejected_rows.append(rejection(row["id"],"already_followed","eligibility"))
        elif row.get("blocked"): rejected_rows.append(rejection(row["id"],"blocked_creator","eligibility"))
        elif row.get("reported"): rejected_rows.append(rejection(row["id"],"low_quality_reported","eligibility"))
        elif row.get("relevance",0)<30: rejected_rows.append(rejection(row["id"],"low_relevance","ranking"))
        else: kept.append(row)
    final=rank_creator_discovery(kept)
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":[{"content_id":r["id"],"score_components":{"relevance":score_creator_relevance(r),"quality":score_creator_quality(r),"consistency":score_creator_consistency(r)},"raw_score":creator_score(r)} for r in kept],"creator_discovery":final,"final_feed":final,"debug_trace":[trace(i,True,f"creator {i} ranked by relevance quality and cold-start exposure") for i in final]}
