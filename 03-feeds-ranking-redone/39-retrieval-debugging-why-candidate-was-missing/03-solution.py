import json
from pathlib import Path

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def classify_index_freshness_miss(row): return "index_not_fresh" if row.get("indexed") is False else None
def classify_embedding_version_miss(row): return "embedding_version_mismatch" if row.get("embedding_version") == "old" else None
def classify_retrieval_eligibility_miss(row): return "retrieval_eligibility_filtered" if row.get("eligible") is False else None
def classify_source_quota_miss(row): return "source_quota_overflow" if row.get("quota_overflow") else None
def classify_lexical_tokenization_miss(row): return "lexical_tokenization_miss" if row.get("tokenized") is False else None
def classify_ann_probe_miss(row): return "ann_bucket_not_probed" if row.get("ann_bucket_probed") is False else None
def explain_missing_candidate(row):
    classifiers=[classify_index_freshness_miss,classify_embedding_version_miss,classify_retrieval_eligibility_miss,classify_source_quota_miss,classify_lexical_tokenization_miss,classify_ann_probe_miss]
    for classifier in classifiers:
        reason=classifier(row)
        if reason: return {"content_id":row["id"],"reason":reason,"stage":"retrieval"}
    return None
def run(dataset_path):
    data=load_dataset(dataset_path); candidates=[]; missing=[]
    for row in data["items"]:
        if row.get("retrieved"):
            candidates.append({"content_id":row["id"],"source":row["source"]})
        else:
            explanation=explain_missing_candidate(row)
            if explanation: missing.append(explanation)
    ids=[row["content_id"] for row in candidates]
    trace=[]
    for row in data["items"]:
        if row["id"] in ids:
            why=f"{row['id']} retrieved by {row['source']} source"
        else:
            why=next(item["reason"] for item in missing if item["content_id"]==row["id"])
        trace.append({"content_id":row["id"],"included":row["id"] in ids,"why":why})
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["followed","semantic","exploration"],"retrieved_candidates":candidates,"final_candidate_pool":ids,"missing_candidate_explanations":missing,"missed_candidates":missing,"rejected_items":[],"retrieval_debug_trace":trace,"debug_trace":trace}
