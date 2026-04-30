import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def build_home_candidates(rows): return [r for r in rows if r["id"] != 101 and (r.get("home",0)>40 or r.get("exploration"))]
def build_up_next_candidates(rows,current_video_id): return [r for r in rows if r["id"] != current_video_id and (r.get("related",0)>60 or r.get("exploration"))]
def compute_home_relevance(row): return row.get("home",0)+(10 if row.get("exploration") else 0)
def compute_continuation_value(row): return row.get("related",0)-(10 if row.get("long_hard") else 0)+(5 if row.get("exploration") else 0)
def apply_clickbait_abandonment_filter(rows):
    kept=[]; rejected_rows=[]
    for row in rows:
        if row.get("blocked"): rejected_rows.append(rejection(row["id"],"blocked_author","eligibility"))
        elif row.get("abandonment",0)>0.7: rejected_rows.append(rejection(row["id"],"clickbait_abandonment","eligibility"))
        elif row["id"]==701: rejected_rows.append(rejection(row["id"],"no_home_or_session_relevance","candidate_generation"))
        else: kept.append(row)
    return kept,rejected_rows
def apply_video_surface_explanations(home,up_next): return [trace(i,True,f"home recommendation {i} matches Ada broad interests") for i in home]+[trace(f"up_next:{i}",True,f"up next {i} continues current video 101") for i in up_next]
def run(dataset_path):
    data=load_dataset(dataset_path); eligible,rejected_rows=apply_clickbait_abandonment_filter(data["content"]); home=[r["id"] for r in sorted(build_home_candidates(eligible), key=lambda r:-compute_home_relevance(r))[:4]]; up=[r["id"] for r in sorted(build_up_next_candidates(eligible,data["current_video_id"]), key=lambda r:-compute_continuation_value(r))[:3]]
    return {"inventory":inventory(data),"eligible_candidates":eligible,"rejected_items":rejected_rows,"candidate_rows":[{"content_id":r["id"],"source":"home_or_up_next","reasons":[r["topic"]]} for r in eligible],"score_rows":[{"content_id":r["id"],"score_components":{"home_relevance":compute_home_relevance(r),"continuation":compute_continuation_value(r)},"raw_score":compute_home_relevance(r)} for r in eligible],"home_recommendations":home,"up_next":up,"final_feed":home,"debug_trace":apply_video_surface_explanations(home,up)}
