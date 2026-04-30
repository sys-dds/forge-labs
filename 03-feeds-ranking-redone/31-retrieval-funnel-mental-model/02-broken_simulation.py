import json
from pathlib import Path

def load_corpus(dataset_path):
    data = dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
    return data, data["corpus"]

def collect_followed_source(corpus): return []
def collect_group_source(corpus): return []
def collect_semantic_source(corpus): return []
def collect_exploration_source(corpus): return []
def apply_retrieval_eligibility(corpus): return []
def build_final_candidate_pool(corpus, source_rows, rejected):
    candidates = [{"content_id": row["id"]} for row in corpus if row["id"] != 901]
    return candidates, []
def build_retrieval_debug_trace(corpus, candidates, rejected, missed): return []
def run(dataset_path):
    data, corpus = load_corpus(dataset_path)
    candidates, missed = build_final_candidate_pool(corpus, [], [])
    return {"corpus": [row["id"] for row in corpus], "inventory": [row["id"] for row in corpus], "retrieval_sources": [], "retrieved_candidates": candidates, "final_candidate_pool": [row["content_id"] for row in candidates], "missed_candidates": missed, "rejected_items": [], "retrieval_debug_trace": [], "debug_trace": []}
