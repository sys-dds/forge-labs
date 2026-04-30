import json
from pathlib import Path

def load_corpus(dataset_path):
    data = dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
    return data, data["corpus"]

def collect_followed_source(corpus):
    return [{"content_id": row["id"], "source": "followed_author"} for row in corpus if row.get("followed")]

def collect_group_source(corpus):
    return [{"content_id": row["id"], "source": "group"} for row in corpus if row.get("group") == "Backend Club"]

def collect_semantic_source(corpus):
    return [{"content_id": row["id"], "source": "semantic_similarity"} for row in corpus if row.get("semantic_match")]

def collect_exploration_source(corpus):
    return [{"content_id": row["id"], "source": "exploration"} for row in corpus if row.get("exploration") or (row.get("cold_start") and row.get("fresh"))]

def apply_retrieval_eligibility(corpus):
    rejected = []
    for row in corpus:
        if row.get("muted"):
            rejected.append({"content_id": row["id"], "reason": "muted_author", "stage": "retrieval_eligibility"})
        elif row.get("blocked"):
            rejected.append({"content_id": row["id"], "reason": "blocked_author", "stage": "retrieval_eligibility"})
        elif row.get("unsafe"):
            rejected.append({"content_id": row["id"], "reason": "unsafe_content", "stage": "retrieval_eligibility"})
    return rejected

def build_final_candidate_pool(corpus, source_rows, rejected):
    rejected_ids = {row["content_id"] for row in rejected}
    best_source = {}
    priority = {"followed_author": 1, "group": 2, "semantic_similarity": 3, "exploration": 4}
    for row in source_rows:
        content_id = row["content_id"]
        if content_id in rejected_ids:
            continue
        if content_id not in best_source or priority[row["source"]] < priority[best_source[content_id]]:
            best_source[content_id] = row["source"]
    ordered = sorted(best_source, key=lambda item_id: (priority[best_source[item_id]], item_id))
    candidates = [{"content_id": item_id, "source": best_source[item_id]} for item_id in ordered]
    missed = []
    for row in corpus:
        if row["id"] not in best_source and row["id"] not in rejected_ids:
            missed.append({"content_id": row["id"], "reason": "no_retrieval_source", "stage": "retrieval"})
    return candidates, missed

def build_retrieval_debug_trace(corpus, candidates, rejected, missed):
    candidate_sources = {row["content_id"]: row["source"] for row in candidates}
    reasons = {row["content_id"]: row["reason"] for row in rejected + missed}
    trace = []
    for row in corpus:
        content_id = row["id"]
        if content_id in candidate_sources:
            trace.append({"content_id": content_id, "included": True, "why": f"{content_id} kept by {candidate_sources[content_id]} retrieval source"})
        else:
            trace.append({"content_id": content_id, "included": False, "why": f"{content_id} {reasons[content_id]} before ranking"})
    return trace

def run(dataset_path):
    data, corpus = load_corpus(dataset_path)
    sources = []
    sources.extend(collect_followed_source(corpus))
    sources.extend(collect_group_source(corpus))
    sources.extend(collect_semantic_source(corpus))
    sources.extend(collect_exploration_source(corpus))
    rejected = apply_retrieval_eligibility(corpus)
    candidates, missed = build_final_candidate_pool(corpus, sources, rejected)
    trace = build_retrieval_debug_trace(corpus, candidates, rejected, missed)
    return {"corpus": [row["id"] for row in corpus], "inventory": [row["id"] for row in corpus], "retrieval_sources": sources, "retrieved_candidates": candidates, "final_candidate_pool": [row["content_id"] for row in candidates], "missed_candidates": missed, "rejected_items": rejected, "retrieval_debug_trace": trace, "debug_trace": trace}
