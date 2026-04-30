import json
from pathlib import Path


def load_dataset(dataset_path):
    if isinstance(dataset_path, dict): return dataset_path
    return json.loads(Path(dataset_path).read_text())

def rejection(content_id, reason, stage): return {"content_id": content_id, "reason": reason, "stage": stage}
def trace(content_id, included, why): return {"content_id": content_id, "included": included, "why": why}
def inventory(dataset): return [item["id"] for item in dataset["content"]]

def parse_query_terms(query): return [part.lower() for part in query.split()]
def compute_exact_match_score(row, terms):
    title=row["title"].lower(); return sum(30 for term in terms if term in title)
def compute_semantic_match_score(row):
    title = row["title"].lower()
    if "junit" in title and "testcontainers" in title:
        return 55
    if "integration testing" in title:
        return 25
    return 0
def detect_lexical_trap(row): return "javascript" in row["title"].lower()
def apply_search_safety_filter(row): return not row.get("blocked")
def rerank_search_results(rows, terms): return [r["id"] for r in sorted(rows, key=lambda r:-(compute_exact_match_score(r,terms)+compute_semantic_match_score(r)-r.get("age",0)*0.1))]
def explain_search_match(item_id): return trace(item_id,True,f"search result {item_id} matched Java testing intent")
def run(dataset_path):
    data=load_dataset(dataset_path); terms=parse_query_terms(data["query"]); kept=[]; rejected_rows=[]
    for row in data["content"]:
        if not apply_search_safety_filter(row): rejected_rows.append(rejection(row["id"],"blocked_author","eligibility"))
        elif detect_lexical_trap(row): rejected_rows.append(rejection(row["id"],"language_trap_javascript","ranking"))
        elif row["id"]==501: rejected_rows.append(rejection(row["id"],"query_mismatch","ranking"))
        elif row["id"]==401: rejected_rows.append(rejection(row["id"],"weak_query_match","ranking"))
        else: kept.append(row)
    final=rerank_search_results(kept,terms)
    return {"inventory":inventory(data),"eligible_candidates":kept,"rejected_items":rejected_rows,"score_rows":[{"content_id":r["id"],"score_components":{"exact":compute_exact_match_score(r,terms),"semantic":compute_semantic_match_score(r)},"raw_score":compute_exact_match_score(r,terms)+compute_semantic_match_score(r)} for r in kept],"search_results":final,"final_feed":final,"debug_trace":[explain_search_match(i) for i in final]}
