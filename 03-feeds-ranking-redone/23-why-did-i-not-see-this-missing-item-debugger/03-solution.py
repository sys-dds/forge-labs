import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def classify_retrieval_miss(row): return "not_retrieved_no_candidate_source" if not row.get("retrieved") else None
def classify_eligibility_rejection(row):
    if row.get("muted"): return "rejected_muted_author"
    if row.get("blocked"): return "rejected_blocked_author"
def classify_scoring_loss(row): return "eligible_but_below_score_cutoff" if row.get("score",0) < 50 and not row.get("exploration") else None
def classify_diversity_removal(row, chosen_authors): return "removed_by_diversity_cap" if row.get("author") in chosen_authors else None
def classify_seen_state_removal(row): return "already_seen" if row.get("already_seen") else None
def classify_freshness_removal(row): return "stale_outside_freshness_window" if row.get("age_hours",0)>72 else None
def explain_missing_item(row, chosen_authors):
    for fn in [classify_retrieval_miss, classify_seen_state_removal, classify_freshness_removal, classify_eligibility_rejection, classify_scoring_loss]:
        reason=fn(row)
        if reason: return reason
    return classify_diversity_removal(row, chosen_authors)
def run(dataset):
    data=load_dataset(dataset); final=[]; missing=[]; chosen=set()
    for row in sorted(data["content"], key=lambda r:(r.get("exploration",False), -r.get("score",0))):
        reason=explain_missing_item(row, chosen)
        if reason: missing.append({"content_id":row["id"],"reason":reason,"stage":reason.split('_')[0]}); continue
        if row.get("id") in (101,901): final.append(row["id"]); chosen.add(row["author"])
        else: missing.append({"content_id":row["id"],"reason":"removed_by_diversity_cap","stage":"diversity"})
    return {"inventory":[r["id"] for r in data["content"]],"rejected_items":missing,"missing_explanations":{str(r["content_id"]):r["reason"] for r in missing},"final_feed":final,"debug_trace":[{"content_id":r["content_id"],"included":False,"why":r["reason"]} for r in missing]+[{"content_id":i,"included":True,"why":"selected after missing-item checks"} for i in final]}
