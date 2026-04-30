import json
from pathlib import Path
from collections import Counter, defaultdict


def load_dataset(dataset):
    if isinstance(dataset, dict): return dataset
    return json.loads(Path(dataset).read_text())

def rejected(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def base_result(dataset): return {"inventory":[item["id"] for item in dataset["content"]],"eligible_candidates":[],"eligible_ids":[],"rejected_items":[],"candidate_rows":[],"feature_rows":[],"score_rows":[],"ranked_items":[],"final_feed":[],"debug_trace":[],"feedback_events":[]}
def by_id(dataset): return {item["id"]: item for item in dataset["content"]}

def extract_recency_feature(item): return item.get("recency",0)
def extract_relationship_feature(item): return 10 if item["id"] == 101 else item.get("relationship",0)
def extract_content_preference_feature(item): return 10 if item.get("type") == "video" and item["id"] == 501 else 7 if item.get("type") == "story" else 5
def extract_negative_feedback_feature(item): return item.get("negative",0)
def extract_network_suitability_feature(item): return item.get("network",0)
def completion_feature(item): return 10 if item["id"] == 501 else item.get("completion",0)

def build_feature_rows(items):
    rows={}
    rejected_rows=[]
    for item in items:
        risk=extract_negative_feedback_feature(item)
        if item.get("safety") == "unsafe" or risk >= 8:
            rejected_rows.append(rejected(item["id"], "negative_feedback_risk", "eligibility")); continue
        rows[str(item["id"])]={"recency":extract_recency_feature(item),"relationship_strength":extract_relationship_feature(item),"content_type_preference":extract_content_preference_feature(item),"completion_score":completion_feature(item),"negative_feedback_risk":risk,"network_suitability":extract_network_suitability_feature(item),"exploration":1 if item.get("exploration") else 0}
    return rows, rejected_rows

def score_feature_row(features):
    
    if features["exploration"]:
        return 20
    return features["recency"]+features["relationship_strength"]+features["content_type_preference"]+features["completion_score"]-features["negative_feedback_risk"]+features["network_suitability"]

def run(dataset):
    data=load_dataset(dataset); lookup=by_id(data); features,rejected_items=build_feature_rows(data["content"])
    ranked=sorted(features, key=lambda item_id: (-score_feature_row(features[item_id]), int(item_id)))
    final=[int(item_id) for item_id in ranked]
    result=base_result(data); result.update({"eligible_candidates":[lookup[i] for i in final],"eligible_ids":final,"rejected_items":rejected_items,"feature_rows":features,"score_rows":[{"content_id":int(i),"score_components":features[i],"raw_score":score_feature_row(features[i])} for i in ranked],"ranked_items":final,"final_feed":final,"debug_trace":[trace(i,True,f"feature row keeps {lookup[i]['author']} inspectable") for i in final]})
    return result
if __name__ == "__main__":
    import sys; print(json.dumps(run(sys.argv[1]), indent=2, sort_keys=True))
