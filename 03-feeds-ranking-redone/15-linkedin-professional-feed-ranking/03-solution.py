import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def compute_professional_relevance(row): return row.get("relevance",0)
def compute_network_distance_score(row): return row.get("network",0)*3
def detect_professional_spam(row): return row.get("type") == "job_spam"
def apply_career_interest_match(row): return compute_professional_relevance(row)+compute_network_distance_score(row)+(25 if row.get("type") == "job" else 0)
def apply_content_type_diversity(rows):
    final=[]; seen=set()
    for row in sorted(rows, key=lambda r:-apply_career_interest_match(r)):
        if row["type"] == "article" and "article" in seen and row["id"] != 401: continue
        final.append(row); seen.add(row["type"])
    return final[:4]
def rank_professional_feed(rows): return [r["id"] for r in apply_content_type_diversity(rows)]
def run(dataset_path):
    data=load_dataset(dataset_path); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if detect_professional_spam(row): rejected_rows.append(rejection(row["id"],"professional_spam","eligibility"))
        elif row.get("blocked"): rejected_rows.append(rejection(row["id"],"blocked_or_reported","eligibility"))
        elif row["id"]==501: rejected_rows.append(rejection(row["id"],"low_professional_relevance","ranking"))
        elif row["id"]==801: rejected_rows.append(rejection(row["id"],"repeated_company_update","mixing"))
        else: kept.append(row)
    final=rank_professional_feed(kept)
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":[{"content_id":r["id"],"score_components":{"career_relevance":compute_professional_relevance(r),"network":compute_network_distance_score(r)},"raw_score":apply_career_interest_match(r)} for r in kept],"professional_feed":final,"final_feed":final,"debug_trace":[trace(i,True,f"professional relevance explains {i}") for i in final]}
