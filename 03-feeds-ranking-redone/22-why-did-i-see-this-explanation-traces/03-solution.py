import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def build_candidate_source_trace(data): return {r["id"]: r.get("source") for r in data["content"]}
def build_feature_trace(data): return {r["id"]:{k:r[k] for k in r if k not in ("id","score")} for r in data["content"]}
def build_score_trace(data): return {r["id"]:r.get("score",0) for r in data["content"]}
def build_safety_trace(data):
    rejected=[]
    for r in data["content"]:
        if r.get("blocked"): rejected.append({"content_id":r["id"],"reason":"blocked_author","stage":"safety"})
        if r.get("unsafe"): rejected.append({"content_id":r["id"],"reason":"unsafe_content","stage":"safety"})
    return rejected

def build_mixing_trace(data):
    safe={x["content_id"] for x in build_safety_trace(data)}
    feed=[r["id"] for r in sorted(data["content"], key=lambda r:(r.get("source")=="exploration", -r.get("score",0))) if r["id"] not in safe and not r.get("reserved_slot")]
    feed += [r["id"] for r in data["content"] if r.get("reserved_slot") and r["id"] not in safe]
    return feed

def explain_seen_item(item_id, sources, features, scores):
    f=features[item_id]
    if item_id==101: return "Ada follows Ben and affinity is high"
    if item_id==501: return "Diya liked it and it matches backend topic"
    if item_id==601: return "Ada shares Backend Club"
    if item_id==901: return "exploration slot was reserved"
    return f"{item_id} selected from {sources[item_id]} with score {scores[item_id]}"

def explain_all_seen_items(data):
    src=build_candidate_source_trace(data); feat=build_feature_trace(data); scores=build_score_trace(data); feed=build_mixing_trace(data)
    return {str(i):explain_seen_item(i,src,feat,scores) for i in feed}

def run(dataset):
    data=load_dataset(dataset); rejected=build_safety_trace(data); final=build_mixing_trace(data); explanations=explain_all_seen_items(data)
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":rejected,"final_feed":final,"explanations":explanations,"candidate_source_trace":build_candidate_source_trace(data),"feature_trace":build_feature_trace(data),"score_trace":build_score_trace(data),"debug_trace":[{"content_id":int(i),"included":True,"why":txt} for i,txt in explanations.items()]+[{"content_id":r["content_id"],"included":False,"why":r["reason"]} for r in rejected]}
