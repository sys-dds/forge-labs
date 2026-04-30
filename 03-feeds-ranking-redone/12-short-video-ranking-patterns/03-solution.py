import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict):
        return dataset_path
    return json.loads(Path(dataset_path).read_text())


def rejection(content_id, reason, stage):
    return {"content_id": content_id, "reason": reason, "stage": stage}


def trace(content_id, included, why):
    return {"content_id": content_id, "included": included, "why": why}


def inventory(dataset):
    return [item["id"] for item in dataset["content"]]

def compute_completion_signal(row): return int(row.get("completion",0)*100)
def compute_rewatch_signal(row): return row.get("rewatch",0)*12
def compute_fast_swipe_penalty(row): return int(row.get("swipe",0)*60)
def compute_hide_report_penalty(row): return row.get("hides",0)*20
def apply_creator_fatigue(row): return max(0,row.get("creator_seen_count",1)-1)*8
def reserve_short_video_exploration_slot(rows): return [r for r in rows if r.get("exploration")]
def score(row): return compute_completion_signal(row)+compute_rewatch_signal(row)-compute_fast_swipe_penalty(row)-apply_creator_fatigue(row)
def rank_short_video_feed(rows): return [r["id"] for r in sorted(rows, key=lambda r:(-score(r), r["id"]))]
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if row.get("blocked"): rejected_rows.append(rejection(row["id"],"blocked_author","eligibility"))
        elif compute_hide_report_penalty(row)>=100 or row.get("swipe",0)>0.8: rejected_rows.append(rejection(row["id"],"high_negative_feedback","eligibility"))
        else: kept.append(row)
    ranked=rank_short_video_feed(kept); rows=[{"content_id":r["id"],"score_components":{"completion":compute_completion_signal(r),"rewatch":compute_rewatch_signal(r),"fast_swipe_penalty":compute_fast_swipe_penalty(r),"creator_fatigue":apply_creator_fatigue(r)},"raw_score":score(r)} for r in kept]
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":rows,"ranked_items":ranked,"short_video_feed":ranked,"final_feed":ranked,"debug_trace":[trace(i,True,f"video {i} ranked by completion, rewatch, swipe, fatigue") for i in ranked]}
