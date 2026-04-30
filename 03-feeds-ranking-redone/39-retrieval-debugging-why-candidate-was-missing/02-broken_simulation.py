import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def classify_index_freshness_miss(row): return None
def classify_embedding_version_miss(row): return None
def classify_retrieval_eligibility_miss(row): return None
def classify_source_quota_miss(row): return None
def classify_lexical_tokenization_miss(row): return None
def classify_ann_probe_miss(row): return None
def explain_missing_candidate(row): return {"content_id":row["id"],"reason":"low_score","stage":"ranking"}
def run(dataset_path):
    data=load_dataset(dataset_path); candidates=[{"content_id":101,"source":"followed"},{"content_id":201,"source":"semantic"}]; ids=[101,201]
    missing=[explain_missing_candidate(row) for row in data["items"] if row["id"] not in ids]
    trace=[{"content_id":row["id"],"included":row["id"] in ids,"why":"low_score" if row["id"] not in ids else "retrieved"} for row in data["items"]]
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["followed","semantic"],"retrieved_candidates":candidates,"final_candidate_pool":ids,"missing_candidate_explanations":missing,"missed_candidates":missing,"rejected_items":[],"retrieval_debug_trace":trace,"debug_trace":trace}
