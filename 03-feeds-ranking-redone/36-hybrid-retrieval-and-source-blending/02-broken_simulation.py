import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def collect_followed_candidates(items): return []
def collect_lexical_candidates(items): return []
def collect_semantic_candidates(items): return []
def collect_trending_candidates(items): return [row for row in items if "trending" in row["sources"]]
def collect_exploration_candidates(items): return []
def merge_sources_with_reasons(source_rows): return [{"content_id":row["id"],"sources":["trending"]} for row in source_rows]
def apply_source_quotas(rows): return rows, []
def build_hybrid_pool(data): return apply_source_quotas(merge_sources_with_reasons(collect_trending_candidates(data["items"])))
def run(dataset_path):
    data=load_dataset(dataset_path); selected,rejected=build_hybrid_pool(data); ids=[row["content_id"] for row in selected]
    trace=[{"content_id":row["id"],"included":row["id"] in ids,"why":"trending only"} for row in data["items"]]
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["trending"],"hybrid_candidates":ids,"retrieved_candidates":[{"content_id":item,"source":"trending"} for item in ids],"final_candidate_pool":ids,"missed_candidates":[],"rejected_items":rejected,"retrieval_debug_trace":trace,"debug_trace":trace}
