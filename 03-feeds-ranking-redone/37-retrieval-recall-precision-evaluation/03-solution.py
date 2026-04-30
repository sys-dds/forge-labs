import json
from pathlib import Path
import sys
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from retrieval_math import safe_divide

def load_dataset(dataset_path): return dataset_path if isinstance(dataset_path, dict) else json.loads(Path(dataset_path).read_text())
def compute_recall(relevant, retrieved): return round(safe_divide(len(set(relevant)&set(retrieved)), len(set(relevant))), 2)
def compute_precision(relevant, retrieved): return round(safe_divide(len(set(relevant)&set(retrieved)), len(set(retrieved))), 2)
def identify_false_positives(relevant, retrieved): return [item for item in retrieved if item not in relevant]
def identify_false_negatives(relevant, retrieved): return [item for item in relevant if item not in retrieved]
def compare_retrieval_strategies(data):
    reports={}
    for name,retrieved in data["strategies"].items():
        reports[name]={"retrieved":retrieved,"recall":compute_recall(data["relevant_items"],retrieved),"precision":compute_precision(data["relevant_items"],retrieved),"false_positives":identify_false_positives(data["relevant_items"],retrieved),"false_negatives":identify_false_negatives(data["relevant_items"],retrieved)}
    return reports
def choose_first_stage_strategy(reports): return sorted(reports, key=lambda name:(-reports[name]["recall"], -reports[name]["precision"], name))[0]
def run(dataset_path):
    data=load_dataset(dataset_path); reports=compare_retrieval_strategies(data); winner=choose_first_stage_strategy(reports)
    trace=[]
    for name,report in reports.items(): trace.append({"content_id":name,"included":name==winner,"why":f"{name} recall {report['recall']} precision {report['precision']} false negatives {report['false_negatives']}"})
    return {"corpus":data["relevant_items"]+reports["Strategy A"]["false_positives"],"inventory":data["relevant_items"],"retrieval_sources":["Strategy A","Strategy B"],"retrieved_candidates":[{"content_id":name,"source":"evaluation_strategy","items":report["retrieved"]} for name,report in reports.items()],"final_candidate_pool":reports[winner]["retrieved"],"missed_candidates":[{"content_id":item,"reason":"false_negative_in_strategy_b","stage":"retrieval_evaluation"} for item in reports["Strategy B"]["false_negatives"]],"rejected_items":[{"content_id":item,"reason":"false_positive_in_strategy_a","stage":"precision_review"} for item in reports["Strategy A"]["false_positives"]],"recall_report":{name:report["recall"] for name,report in reports.items()},"precision_report":{name:report["precision"] for name,report in reports.items()},"false_positives":{name:report["false_positives"] for name,report in reports.items()},"false_negatives":{name:report["false_negatives"] for name,report in reports.items()},"winner_for_first_stage_retrieval":winner,"retrieval_debug_trace":trace,"debug_trace":trace}
