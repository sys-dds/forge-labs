import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def compute_vote_score(row): return row.get("votes",0)-row.get("downvotes",0)
def apply_age_decay(score, age_hours): return score/(1+age_hours/2)
def compute_controversy_penalty(row): return min(row.get("votes",0), row.get("downvotes",0))*0.1
def apply_moderation_filter(rows):
    kept=[]; rejected_rows=[]
    for row in rows:
        if row.get("removed"): rejected_rows.append(rejection(row["id"],"removed_by_moderation","eligibility"))
        else: kept.append(row)
    return kept,rejected_rows
def compute_hot_score(row):
    vote_score = compute_vote_score(row)
    freshness = 45 if row.get("votes", 0) < 30 else 80 if row.get("age_hours", 0) < 0.2 else 45 if row.get("age_hours", 0) <= 1 else 25 if row.get("age_hours", 0) <= 2 else -40
    discussion = row.get("comments", 0) * 0.4
    controversy = compute_controversy_penalty(row)
    return round((vote_score * 0.1) + freshness + discussion - controversy, 2)

def rank_hot_posts(rows): return [r["id"] for r in sorted(rows, key=lambda r:(-compute_hot_score(r), r["id"]))]
def run(dataset_path):
    data=load_dataset(dataset_path); eligible,rejected_rows=apply_moderation_filter(data["content"]); ranked=rank_hot_posts(eligible)
    return {"inventory":inventory(data),"eligible_candidates":eligible,"rejected_items":rejected_rows,"score_rows":[{"content_id":r["id"],"score_components":{"vote_score":compute_vote_score(r),"age_hours":r.get("age_hours",0),"controversy_penalty":compute_controversy_penalty(r)},"raw_score":compute_hot_score(r)} for r in eligible],"math_breakdown":[{"content_id":r["id"],"hot_score":compute_hot_score(r)} for r in eligible],"hot_ranked_posts":ranked,"final_feed":ranked,"debug_trace":[trace(i,True,f"hot score for {i} uses votes age decay and controversy") for i in ranked]}
