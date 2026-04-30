import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def classify_missing_edge_ingestion(row):
    if row["state"] == "missing_edge_not_ingested": return "edge_not_ingested"

def classify_expired_edge(row):
    if row["state"] == "edge_expired": return "edge_expired"

def classify_blocked_path(row):
    if row["state"] == "blocked_author_path": return "blocked_author_path"

def classify_weak_community_affinity(row):
    if row["state"] == "community_membership_too_weak": return "weak_community_affinity"

def classify_source_quota_overflow(row):
    if row["state"] == "source_quota_overflow": return "source_quota_overflow"

def explain_missing_graph_candidate(row):
    for classifier in [classify_missing_edge_ingestion, classify_expired_edge, classify_blocked_path, classify_weak_community_affinity, classify_source_quota_overflow]:
        reason = classifier(row)
        if reason:
            return {"content_id": row["id"], "reason": reason, "stage": "graph_retrieval"}
    return None

def run(dataset):
    data = as_dataset(dataset); candidates = []; missing = []
    for row in data["candidates"]:
        if row["state"].startswith("retrieved") or row["state"] == "candidate_retrieved":
            candidates.append(row["id"])
        else:
            missing.append(explain_missing_graph_candidate(row))
    trace = [{"content_id": item, "why": "retrieved by graph source path"} for item in candidates]
    trace += [{"content_id": row["content_id"], "why": f"graph failure {row['reason']}"} for row in missing]
    return {"inventory": data["candidates"], "nodes": [row["id"] for row in data["candidates"]], "edges": [], "graph_candidates": candidates, "final_candidate_pool": candidates, "missing_graph_explanations": missing, "missed_graph_candidates": missing, "rejected_items": [], "graph_debug_trace": trace, "debug_trace": trace}
