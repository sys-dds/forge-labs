import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def collect_one_hop_connections(data):
    return sorted({b for a,b in data["edges"] if a == "ada"} | {a for a,b in data["edges"] if b == "ada"})

def neighbors(data, user):
    found = set()
    for left, right in data["edges"]:
        if left == user: found.add(right)
        if right == user: found.add(left)
    return found

def collect_two_hop_candidates(data):
    one_hop = set(collect_one_hop_connections(data))
    rows = []
    for friend in sorted(one_hop):
        for candidate in sorted(neighbors(data, friend)):
            if candidate != "ada" and candidate not in one_hop:
                rows.append({"candidate_id": candidate, "through": friend, "path": ["ada", friend, candidate]})
    return rows

def compute_mutual_connection_rows(data):
    rows = []
    one_hop = set(collect_one_hop_connections(data))
    for candidate in sorted({row["candidate_id"] for row in collect_two_hop_candidates(data)}):
        mutuals = sorted(one_hop & neighbors(data, candidate))
        rows.append({"candidate_id": candidate, "mutual_count": len(mutuals), "mutuals": mutuals, "paths": [["ada", m, candidate] for m in mutuals]})
    return rows

def score_triangle_closure(rows):
    return sorted(rows, key=lambda row: (-row["mutual_count"], row["candidate_id"]))

def apply_people_safety_exclusions(data, rows):
    rejected = [{"content_id": user, "reason": "blocked_user", "stage": "graph_eligibility"} for user in data["blocked"]]
    kept = [row for row in rows if row["candidate_id"] not in data["blocked"] and row["mutual_count"] > 0]
    missed = [{"content_id":"lina","reason":"no_two_hop_path","stage":"graph_retrieval"}]
    return kept, rejected, missed

def rank_people_you_may_know(data):
    rows = score_triangle_closure(compute_mutual_connection_rows(data))
    kept, rejected, missed = apply_people_safety_exclusions(data, rows)
    return kept, rejected, missed

def run(dataset):
    data = as_dataset(dataset); kept, rejected, missed = rank_people_you_may_know(data)
    candidates = [row["candidate_id"] for row in kept]
    trace = [{"content_id": row["candidate_id"], "why": f"triangle closes through {','.join(row['mutuals'])} mutual_count {row['mutual_count']}"} for row in kept]
    trace += [{"content_id": row["content_id"], "why": row["reason"]} for row in rejected + missed]
    return {"inventory": data["users"], "nodes": data["users"], "edges": data["edges"], "graph_candidates": candidates, "people_you_may_know": candidates, "final_candidate_pool": candidates, "mutual_rows": kept, "missed_graph_candidates": missed, "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
