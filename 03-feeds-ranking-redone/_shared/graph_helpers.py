"""Tiny graph helpers shared by feed graph clinics.

These helpers know graph shapes, not clinic business rules.
"""


def build_adjacency_list(edges):
    graph = {}
    for edge in edges:
        graph.setdefault(edge["from"], []).append(edge)
    return graph


def outgoing_neighbors(graph, node_id):
    return [edge["to"] for edge in graph.get(node_id, [])]


def incoming_neighbors(edges, node_id):
    return [edge["from"] for edge in edges if edge.get("to") == node_id]


def mutual_neighbors(graph, left_id, right_id):
    left = set(outgoing_neighbors(graph, left_id))
    right = set(outgoing_neighbors(graph, right_id))
    return sorted(left & right)


def count_shared_neighbors(graph, left_id, right_id):
    return len(mutual_neighbors(graph, left_id, right_id))


def edge_weight(edge):
    return edge.get("weight", 1.0)


def safe_divide(numerator, denominator):
    if denominator == 0:
        return 0.0
    return numerator / denominator


def stable_top_k(rows, key, k):
    return sorted(rows, key=key)[:k]
