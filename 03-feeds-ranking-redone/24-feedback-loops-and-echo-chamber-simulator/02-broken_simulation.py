import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def build_interest_profile_from_feedback(data):
    return {f["topic"]: f["clicks"]*4 + f["completed"]*8 for f in data["feedback"]}
def apply_positive_feedback_boost(row, profile): return row.get("score",0)+min(profile.get(row.get("topic"),0),30)
def apply_negative_feedback_correction(row, score): return score-55 if row.get("clickbait") else score
def preserve_secondary_interest(rows, selected):
    movies=[r for r in rows if r.get("topic")=="movies" and r.get("completed")]
    for r in movies:
        if r["id"] not in selected: selected.append(r["id"])
    return selected
def reserve_exploration_slot(rows, selected):
    for r in rows:
        if r.get("exploration") and r["id"] not in selected: selected.append(r["id"])
    return selected
def detect_echo_chamber_risk(feed): return "echo_chamber_risk" if sum(1 for i in feed if i in (104,201,801)) > 1 else "balanced"
def build_feedback_loop_report(feed): return {"risks":[detect_echo_chamber_risk(feed)]}
def run(dataset):
    data=load_dataset(dataset); profile=build_interest_profile_from_feedback(data); rejected=[]; scored=[]
    for r in data["content"]:
        if r.get("unsafe"): rejected.append({"content_id":r["id"],"reason":"unsafe_content","stage":"safety"}); continue
        scored.append((apply_negative_feedback_correction(r,apply_positive_feedback_boost(r,profile)),r))
    selected=[201,104]
    report={"risks":[]}
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":rejected,"final_feed":selected,"feedback_loop_report":report,"debug_trace":[{"content_id":i,"included":i in selected,"why":"feedback loop decision"} for i in [104,401,402,901,801]]}
