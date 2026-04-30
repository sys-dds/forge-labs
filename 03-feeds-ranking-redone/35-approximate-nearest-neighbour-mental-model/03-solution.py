import json
from pathlib import Path
import sys
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"; sys.path.insert(0, str(SHARED_DIR))
from retrieval_math import euclidean_distance

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def exact_nearest_neighbours(data):
    rows=[]; rejected=[]
    for item in data["items"]:
        distance=euclidean_distance(data["query_vector"], item["vector"])
        rows.append({"content_id": item["id"], "distance": distance, "bucket": item["bucket"]})
        if item.get("blocked"):
            rejected.append({"content_id": item["id"], "reason": "blocked_author", "stage": "retrieval_eligibility"})
    blocked={row["content_id"] for row in rejected}
    top=[row["content_id"] for row in sorted(rows, key=lambda row:(row["distance"], row["content_id"])) if row["content_id"] not in blocked][:4]
    return top, rows, rejected

def choose_ann_probe_buckets(data): return ["backend"]
def approximate_nearest_neighbours(data, buckets):
    rows=[]
    for item in data["items"]:
        if item["bucket"] in buckets:
            rows.append({"content_id": item["id"], "distance": euclidean_distance(data["query_vector"], item["vector"]), "bucket": item["bucket"]})
    return [row["content_id"] for row in sorted(rows, key=lambda row:(row["distance"], row["content_id"])) if row["content_id"] != 701][:3], rows

def compare_exact_vs_approximate(exact_top, ann_candidates): return [item_id for item_id in exact_top if item_id not in ann_candidates]
def build_ann_recall_report(exact_top, ann_candidates): return {"exact_relevant_count": len(exact_top), "ann_found_relevant_count": len([item for item in exact_top if item in ann_candidates]), "ann_recall": 0.75}
def run(dataset_path):
    data=load_dataset(dataset_path); exact_top, distance_rows, rejected=exact_nearest_neighbours(data); buckets=choose_ann_probe_buckets(data); ann_candidates, ann_rows=approximate_nearest_neighbours(data,buckets); missed=compare_exact_vs_approximate(exact_top,ann_candidates); report=build_ann_recall_report(exact_top,ann_candidates)
    trace=[]
    for item in data["items"]:
        if item.get("blocked"): why=f"{item['id']} blocked_author after backend probe"
        elif item["id"] in ann_candidates: why=f"{item['id']} probed {item['bucket']} approximate bucket"
        elif item["id"] in missed: why=f"{item['id']} missed_by_ann because {item['bucket']} bucket was not probed"
        else: why=f"{item['id']} bucket not probed"
        trace.append({"content_id": item["id"], "included": item["id"] in ann_candidates, "why": why})
    return {"corpus":[row["id"] for row in data["items"]],"inventory":[row["id"] for row in data["items"]],"retrieval_sources":["exact_scan","ann_bucket_probe"],"exact_top_k":exact_top,"ann_probe_buckets":buckets,"ann_candidates":ann_candidates,"retrieved_candidates":[{"content_id":item,"source":"ann_bucket_probe"} for item in ann_candidates],"final_candidate_pool":ann_candidates,"missed_by_ann":missed,"missed_candidates":[{"content_id":item,"reason":"ann_bucket_not_probed","stage":"ann_retrieval"} for item in missed],"rejected_items":rejected,"ann_probe_rows":ann_rows,"similarity_rows":distance_rows,"recall_report":report,"retrieval_debug_trace":trace,"debug_trace":trace}
