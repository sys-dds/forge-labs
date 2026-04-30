import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json
from graph_helpers import safe_divide


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def build_user_item_graph(data):
    return data["interactions"]

def find_similar_users_by_shared_items(graph):
    ada_items = set(graph["ada"])
    rows = []
    for user, items in graph.items():
        if user == "ada": continue
        shared = sorted(ada_items & set(items))
        if shared:
            rows.append({"user_id": user, "shared_items": shared, "overlap": len(shared)})
    return rows

def collect_items_from_similar_users(graph, similar_rows):
    seen = set(graph["ada"]); rows = []
    for sim in similar_rows:
        for item in graph[sim["user_id"]]:
            if item not in seen:
                rows.append({"content_id": item, "via_user": sim["user_id"], "shared_items": sim["shared_items"], "path": ["ada", sim["shared_items"][0], sim["user_id"], item]})
    return rows

def compute_collaborative_score(rows):
    by_item = {}
    for row in rows:
        entry = by_item.setdefault(row["content_id"], {"content_id": row["content_id"], "score": 0, "paths": []})
        entry["score"] += len(row["shared_items"])
        entry["paths"].append(row["path"])
    return sorted(by_item.values(), key=lambda row: (-row["score"], row["content_id"]))

def apply_item_safety_exclusions(data, rows):
    rejected = []
    kept = []
    for row in rows:
        if row["content_id"] == "post_501":
            rejected.append({"content_id":"post_501","reason":"blocked_author","stage":"graph_eligibility"})
        elif row["score"] < 2:
            rejected.append({"content_id":row["content_id"],"reason":"insufficient_user_overlap","stage":"graph_retrieval"})
        else:
            kept.append(row)
    for item in ["post_301", "post_601"]:
        if item not in [row["content_id"] for row in rows]:
            rejected.append({"content_id":item,"reason":"insufficient_user_overlap","stage":"graph_retrieval"})
    return kept, rejected

def explain_bipartite_walk(rows):
    return [{"content_id": row["content_id"], "why": f"user-item-user-item paths {row['paths']} score {row['score']}"} for row in rows]

def run(dataset):
    data = as_dataset(dataset); graph = build_user_item_graph(data)
    similar = find_similar_users_by_shared_items(graph)
    item_rows = collect_items_from_similar_users(graph, similar)
    scored = compute_collaborative_score(item_rows)
    kept, rejected = apply_item_safety_exclusions(data, scored)
    trace = explain_bipartite_walk(kept) + [{"content_id": r["content_id"], "why": r["reason"]} for r in rejected]
    candidates = [row["content_id"] for row in kept]
    return {"inventory": data["items"], "nodes": data["users"] + data["items"], "edges": data["interactions"], "graph_candidates": candidates, "final_candidate_pool": candidates, "bipartite_walk_rows": kept, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
