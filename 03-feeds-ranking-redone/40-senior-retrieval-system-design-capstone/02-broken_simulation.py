import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def build_source_registry(): return [{"name":"semantic"}]
def run_lexical_retrieval(items): return []
def run_semantic_retrieval(items): return [row for row in items if row.get("source") in {"semantic","trending"}]
def run_two_tower_retrieval(items): return []
def run_ann_retrieval(items): return []
def run_cold_start_backfill(items): return []
def apply_retrieval_safety(rows): return rows, []
def blend_retrieval_sources(items): return apply_retrieval_safety(run_semantic_retrieval(items))
def build_missing_candidate_explanations(items): return []
def build_retrieval_system_design(): return {"source_registry": True, "ranking_handoff_contract": False}
def build_ranking_handoff_contract(candidates, trace): return []
def run(dataset_path):
    data=load_dataset(dataset_path); candidates,rejected=blend_retrieval_sources(data["items"]); ids=[row["id"] for row in candidates]
    trace=[{"content_id":row["id"],"included":row["id"] in ids,"why":"single source only"} for row in data["items"]]
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["semantic"],"retrieved_candidates":[{"content_id":row["id"],"source":"semantic"} for row in candidates],"final_candidate_pool":ids,"missing_candidate_explanations":[],"missed_candidates":[],"rejected_items":rejected,"retrieval_system_design":build_retrieval_system_design(),"ranking_handoff_contract":[],"retrieval_debug_trace":trace,"debug_trace":trace}
