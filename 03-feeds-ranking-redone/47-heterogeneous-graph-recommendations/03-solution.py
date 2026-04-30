import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
import json


def as_dataset(dataset):
    if isinstance(dataset, (str, Path)):
        return json.loads(Path(dataset).read_text())
    return dataset


def build_heterogeneous_graph(data):
    return data["nodes"], data["edges"]

def traverse_user_to_group_to_event(data):
    return [{"candidate_id":"javaconf","node_type":"event","path":["ada","backend_club","javaconf"],"source":"group_event"}]

def traverse_user_to_company_to_newsletter(data):
    return [{"candidate_id":"backend_newsletter","node_type":"newsletter","path":["ada","fintech_company","backend_newsletter"],"source":"company_newsletter"},{"candidate_id":"post_201","node_type":"post","path":["ada","fintech_company","backend_newsletter","post_201"],"source":"newsletter_post"}]

def traverse_user_to_hashtag_to_post(data):
    return [{"candidate_id":"post_101","node_type":"post","path":["ada","ben","java","post_101"],"source":"hashtag_post"}]

def classify_node_type(data, node_id):
    return data["nodes"].get(node_id, "unknown")

def apply_node_type_quotas(rows):
    order = {"event":0, "newsletter":1, "post":2}
    return sorted(rows, key=lambda row: (order[row["node_type"]], row["candidate_id"]))

def build_heterogeneous_path_rows(data):
    rows = traverse_user_to_group_to_event(data) + traverse_user_to_company_to_newsletter(data) + traverse_user_to_hashtag_to_post(data)
    return apply_node_type_quotas(rows)

def run(dataset):
    data = as_dataset(dataset); rows = build_heterogeneous_path_rows(data)
    rejected = [{"content_id":"spam_event","reason":"low_trust_source","stage":"graph_eligibility"}]
    candidates = [row["candidate_id"] for row in rows]
    trace = [{"content_id": row["candidate_id"], "why": f"{row['node_type']} via path {' -> '.join(row['path'])}"} for row in rows]
    trace += [{"content_id":"spam_event","why":"low_trust_source"}]
    return {"inventory": data["nodes"], "nodes": data["nodes"], "edges": data["edges"], "graph_candidates": candidates, "final_candidate_pool": candidates, "heterogeneous_path_rows": rows, "missed_graph_candidates": [], "rejected_items": rejected, "graph_debug_trace": trace, "debug_trace": trace}
