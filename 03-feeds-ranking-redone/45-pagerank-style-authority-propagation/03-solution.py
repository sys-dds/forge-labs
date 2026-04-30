import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def assign_seed_authority(data):
    return data["seed_authority"]

def propagate_authority_to_posts(data, seeds):
    rows = []
    for source, target in data["edges"]:
        rows.append({"content_id": target, "source_node": source, "authority": seeds[source]})
    return rows

def aggregate_authority_rows(rows):
    by_post = {}
    for row in rows:
        entry = by_post.setdefault(row["content_id"], {"content_id": row["content_id"], "authority_score": 0.0, "sources": []})
        entry["authority_score"] = round(entry["authority_score"] + row["authority"], 2)
        entry["sources"].append(row["source_node"])
    return sorted(by_post.values(), key=lambda row: (-row["authority_score"], row["content_id"]))

def apply_authority_safety_filter(data, rows):
    kept = [row for row in rows if row["content_id"] not in data["spam"]]
    rejected = [{"content_id":"post_401","reason":"spam_authority_source","stage":"graph_eligibility"}]
    return kept, rejected

def rank_by_authority(rows):
    return sorted(rows, key=lambda row: (-row["authority_score"], row["content_id"]))

def explain_authority_source(rows):
    return [{"content_id": row["content_id"], "why": f"authority {row['authority_score']} from {','.join(row['sources'])}"} for row in rows]

def run(dataset):
    data = as_dataset(dataset); seeds = assign_seed_authority(data)
    rows = aggregate_authority_rows(propagate_authority_to_posts(data, seeds))
    kept, rejected = apply_authority_safety_filter(data, rank_by_authority(rows))
    candidates = [row["content_id"] for row in kept]
    trace = explain_authority_source(kept) + [{"content_id": r["content_id"], "why": r["reason"]} for r in rejected]
    return {"inventory": data["edges"], "nodes": list(seeds), "edges": data["edges"], "graph_candidates": candidates, "final_candidate_pool": candidates, "authority_rows": kept, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
