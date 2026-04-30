import json
from pathlib import Path
from collections import Counter


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def compute_like_component(item): return round(item["like"] * 20, 2)
def compute_comment_component(item): return round(item["comment"] * 25, 2)
def compute_share_component(item): return round(item["share"] * 20, 2)
def compute_completion_component(item): return round(item["completion"] * 25, 2)
def compute_hide_risk_penalty(item): return item["hide"]
def compute_exploration_bonus(item): return item["exploration"]
def compute_total_score(components): return round(components["like_score"]+components["comment_score"]+components["share_score"]+components["completion_score"]+components["freshness_score"]+components["relationship_score"]-(20*components["hide_penalty"])+components["exploration_bonus"],2)

def build_components(item):
    components={"like_score":compute_like_component(item),"comment_score":compute_comment_component(item),"share_score":compute_share_component(item),"completion_score":compute_completion_component(item),"freshness_score":item["freshness"],"relationship_score":item["relationship"],"hide_penalty":compute_hide_risk_penalty(item),"exploration_bonus":compute_exploration_bonus(item)}
    components["raw_score"]=compute_total_score(components)
    return components

def rank_by_score(score_rows): return [row["content_id"] for row in sorted(score_rows, key=lambda row: (-row["raw_score"], row["content_id"]))]

def run(dataset):
    data=load_dataset(dataset); rows=[]; components={}
    for item in data["content"]:
        comp=build_components(item); components[str(item["id"])] = comp; rows.append({"content_id":item["id"],"score_components":comp,"raw_score":comp["raw_score"]})
    final=rank_by_score(rows)
    result=base_result(data); result.update({"eligible_candidates":data["content"],"eligible_ids":final,"score_rows":[row for item_id in final for row in rows if row["content_id"]==item_id],"score_components":components,"ranked_items":final,"final_feed":final,"debug_trace":[trace(item_id,True,f"score explanation for {item_id}: {components[str(item_id)]['raw_score']}") for item_id in final]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
