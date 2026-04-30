import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def compute_normalised_engagement(row): return round(row["likes"]/10, 1)
def compute_affinity_boost(row): return row.get("affinity",0)
def compute_completion_boost(row): return row.get("completion",0)
def compute_exploration_boost(row): return row.get("exploration",0)
def compute_age_decay_penalty(row): return row.get("age",0)*2
def compute_report_penalty(row): return row.get("reports",0)*25
def compute_total_debuggable_score(row): return round(compute_normalised_engagement(row)+compute_affinity_boost(row)+compute_completion_boost(row)+(compute_exploration_boost(row)*0.1)-compute_age_decay_penalty(row)-compute_report_penalty(row),1)
def rank_with_tie_breaker(rows): return [r["id"] for r in sorted(rows, key=lambda r:(-compute_total_debuggable_score(r), r["id"]))]
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if row.get("blocked"): rejected_rows.append(rejection(row["id"],"blocked_author","eligibility"))
        elif compute_report_penalty(row) >= 100: rejected_rows.append(rejection(row["id"],"high_report_penalty_or_suppressed","eligibility"))
        else: kept.append(row)
    final=rank_with_tie_breaker(kept); rows=[{"content_id":r["id"],"score_components":{"normalised_engagement":compute_normalised_engagement(r),"affinity_boost":compute_affinity_boost(r),"completion_boost":compute_completion_boost(r),"exploration_boost":compute_exploration_boost(r),"age_decay":compute_age_decay_penalty(r),"report_penalty":compute_report_penalty(r)},"raw_score":compute_total_debuggable_score(r)} for r in kept]
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":rows,"math_breakdown":rows,"final_feed":final,"debug_trace":[trace(i,True,f"score math for {i} uses normalisation boosts decay and penalties") for i in final]}
