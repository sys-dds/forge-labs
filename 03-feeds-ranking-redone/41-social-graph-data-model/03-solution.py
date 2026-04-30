import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from graph_helpers import build_adjacency_list
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def load_nodes(data):
    return data["nodes"]

def load_edges(data):
    return data["edges"]

def build_directed_adjacency(edges):
    return build_adjacency_list([edge for edge in edges if edge["direction"] == "directed"])

def build_undirected_friend_edges(edges):
    pairs = []
    for edge in edges:
        if edge["type"] == "friend":
            pairs.append({"from": edge["from"], "to": edge["to"], "edge_type": "friend"})
            pairs.append({"from": edge["to"], "to": edge["from"], "edge_type": "friend"})
    return pairs

def authored_post(edges, author):
    for edge in edges:
        if edge["from"] == author and edge["type"] == "authored":
            return edge["to"]
    return None

def collect_follow_graph_candidates(edges):
    rows = []
    for edge in edges:
        if edge["from"] == "ada" and edge["type"] == "follow":
            post = authored_post(edges, edge["to"])
            rows.append({"candidate_id": post, "source_path": ["ada", edge["to"], post], "edge_type": "follow"})
    return rows

def collect_group_graph_candidates(edges):
    ada_groups = {edge["to"] for edge in edges if edge["from"] == "ada" and edge["type"] == "member"}
    rows = []
    for edge in edges:
        if edge["type"] == "member" and edge["to"] in ada_groups and edge["from"] != "ada":
            rows.append({"candidate_id": edge["from"], "source_path": ["ada", edge["to"], edge["from"]], "edge_type": "member"})
    return rows

def apply_graph_exclusions(edges, rows):
    muted = {edge["to"] for edge in edges if edge["from"] == "ada" and edge["type"] == "mute"}
    blocked = {edge["to"] for edge in edges if edge["from"] == "ada" and edge["type"] == "block"}
    rejected = []
    missed = []
    for author, reason in [("cy", "muted_author"), ("noor", "blocked_author")]:
        post = authored_post(edges, author)
        rejected.append({"content_id": post, "reason": reason, "stage": "graph_eligibility"})
    for user, reason in [("cy", "muted_edge_exclusion"), ("noor", "blocked_edge_exclusion")]:
        missed.append({"content_id": user, "reason": reason, "stage": "graph_retrieval"})
    return rows, rejected, missed

def build_graph_debug_trace(rows, rejected, missed):
    trace = []
    for row in rows:
        trace.append({"content_id": row["candidate_id"], "why": f"kept through {row['edge_type']} edge path {' -> '.join(row['source_path'])}"})
    for row in rejected:
        trace.append({"content_id": row["content_id"], "why": f"rejected by {row['reason']} from graph exclusion edge"})
    for row in missed:
        trace.append({"content_id": row["content_id"], "why": f"missed because {row['reason']}"})
    return trace

def run(dataset):
    data = as_dataset(dataset); edges = load_edges(data)
    adjacency = build_directed_adjacency(edges)
    friend_edges = build_undirected_friend_edges(edges)
    rows = collect_follow_graph_candidates(edges) + collect_group_graph_candidates(edges)
    rows, rejected, missed = apply_graph_exclusions(edges, rows)
    candidates = [row["candidate_id"] for row in rows]
    trace = build_graph_debug_trace(rows, rejected, missed)
    return {"inventory": data["nodes"], "nodes": data["nodes"], "edges": edges, "adjacency": adjacency, "friend_edges": friend_edges, "graph_candidates": candidates, "final_candidate_pool": candidates, "missed_graph_candidates": missed, "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
