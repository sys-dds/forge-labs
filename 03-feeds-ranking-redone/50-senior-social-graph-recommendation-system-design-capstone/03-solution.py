import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def build_graph_schema():
    return {"node_types":["user","post","community","event"],"edge_types":["follow","friend","like","member","publishes","blocks","mutes"]}

def rows_for(data, source):
    return [row for row in data["rows"] if row.get("source") == source and not row.get("blocked") and not row.get("muted")]

def run_follow_graph_candidates(data):
    return rows_for(data, "follow_graph")

def run_mutual_friend_candidates(data):
    return rows_for(data, "mutual_friend_graph")

def run_bipartite_candidates(data):
    return rows_for(data, "bipartite_graph")

def run_community_candidates(data):
    return rows_for(data, "community_graph")

def run_heterogeneous_candidates(data):
    return rows_for(data, "heterogeneous_event_graph")

def run_fresh_edge_candidates(data):
    return rows_for(data, "fresh_interaction_edge")

def apply_graph_safety(data, rows):
    rejected = []
    for row in data["rows"]:
        if row.get("blocked"):
            rejected.append({"content_id": row["id"], "reason":"blocked_author", "stage":"graph_eligibility"})
        if row.get("muted"):
            rejected.append({"content_id": row["id"], "reason":"muted_author", "stage":"graph_eligibility"})
    return rows, rejected

def build_missing_graph_explanations(data):
    return [{"content_id": row["id"], "reason": row["missing"], "stage":"graph_retrieval"} for row in data["rows"] if "missing" in row]

def build_graph_system_design():
    return {"graph_schema": build_graph_schema(), "traversal_registry":[{"name":"follow_graph","purpose":"followed authors","failure_mode":"stale follow edge"},{"name":"mutual_friend_graph","purpose":"triangle closing","failure_mode":"missing two-hop edge"},{"name":"bipartite_graph","purpose":"user-item overlap","failure_mode":"interaction not ingested"}], "edge_freshness_policy":{"decay":"reply beats old follow","expiry":"drop expired interactions"}, "community_policy":{"cluster_membership":"store strengths","hybrid_items":"allow multi-cluster posts"}, "heterogeneous_policy":{"node_type_quotas":{"event":1,"post":4}}, "safety_policy":{"exclusions":["block","mute","blocked path"]}, "debugging_policy":{"missing_graph_candidate_explanations":["edge_not_ingested","source_quota_overflow"]}}

def build_ranking_handoff_contract(rows):
    return [{"candidate_id": row["id"], "graph_source": row["source"], "path": row["path"], "score": row["score"], "trace": f"{row['id']} from {row['source']} via {' -> '.join(row['path'])}"} for row in rows]

def run(dataset):
    data = as_dataset(dataset)
    rows = run_follow_graph_candidates(data) + run_mutual_friend_candidates(data) + run_bipartite_candidates(data) + run_community_candidates(data) + run_heterogeneous_candidates(data) + run_fresh_edge_candidates(data)
    rows, rejected = apply_graph_safety(data, rows)
    missing = build_missing_graph_explanations(data)
    candidates = [row["id"] for row in rows]
    handoff = build_ranking_handoff_contract(rows)
    design = build_graph_system_design(); design["ranking_handoff_contract"] = {"fields":["candidate_id","graph_source","path","score","trace"], "rows": handoff}
    trace = [{"content_id": row["id"], "why": f"kept from {row['source']} path {' -> '.join(row['path'])}"} for row in rows]
    trace += [{"content_id": row["content_id"], "why": row["reason"]} for row in rejected + missing]
    return {"inventory": data["rows"], "nodes": [row["id"] for row in data["rows"]], "edges": [row.get("path", []) for row in data["rows"]], "graph_candidates": candidates, "final_candidate_pool": candidates, "missing_graph_explanations": missing, "missed_graph_candidates": missing, "rejected_items": rejected, "graph_system_design": design, "ranking_handoff_contract": handoff, "graph_debug_trace": trace, "debug_trace": trace}
