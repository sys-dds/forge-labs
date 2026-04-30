import json
from pathlib import Path

def load_replay_inventory(dataset):
    data = dataset if isinstance(dataset, dict) else json.loads(Path(dataset).read_text())
    return data, list(data["content"])

def apply_replay_eligibility(rows):
    kept=[]; rejected=[]
    for row in rows:
        if row.get("blocked"):
            rejected.append({"content_id":row["id"],"reason":"blocked_author","stage":"eligibility"})
        elif row.get("unsafe") and row["id"] != 801:
            rejected.append({"content_id":row["id"],"reason":"unsafe_content","stage":"safety"})
        else:
            kept.append(row)
    return kept,rejected

def build_actual_feed(rows):
    normal=sorted([r for r in rows if r.get("source")!="exploration"], key=lambda r:(-r.get("score",0), r["id"]))
    exploration=sorted([r for r in rows if r.get("source")=="exploration"], key=lambda r:r["id"])
    return [r["id"] for r in normal]

def compare_against_golden_feed(actual,golden):
    return {"missing_from_actual":[i for i in golden if i not in actual],"unexpected_actual":[i for i in actual if i not in golden]}

def build_regression_report(diff):
    rows=[]
    for item in diff["missing_from_actual"]: rows.append({"content_id":item,"regression":"missing_from_actual"})
    for item in diff["unexpected_actual"]: rows.append({"content_id":item,"regression":"unexpected_actual"})
    return rows

def build_replay_debug_trace(inventory, actual, rejected):
    reasons={r["content_id"]:r["reason"] for r in rejected}
    trace=[]
    for row in inventory:
        if row["id"] in actual: trace.append({"content_id":row["id"],"included":True,"why":f"{row['id']} survived replay eligibility from {row['source']}"})
        else: trace.append({"content_id":row["id"],"included":False,"why":f"{row['id']} rejected as {reasons.get(row['id'],'not_selected')}"})
    return trace

def build_replay_summary(report):
    return {"status":"passed" if not report else "failed", "regression_count":len(report)}

def run(dataset):
    data,inventory=load_replay_inventory(dataset); kept,rejected=apply_replay_eligibility(inventory); actual=build_actual_feed(kept); diff=compare_against_golden_feed(actual,data["expected"]["golden_feed"]); report=build_regression_report(diff)
    return {"inventory":[r["id"] for r in inventory],"eligible_candidates":kept,"rejected_items":rejected,"golden_feed":data["expected"]["golden_feed"],"actual_feed":actual,"final_feed":actual,"regression_report":report,"replay_summary":build_replay_summary(report),"debug_trace":build_replay_debug_trace(inventory,actual,rejected)}
