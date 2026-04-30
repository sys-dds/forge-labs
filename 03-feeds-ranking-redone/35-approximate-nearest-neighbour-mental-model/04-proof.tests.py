import argparse, sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"; sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result,item_id,text):
    if not any(row.get("content_id")==item_id and text in row.get("why","") for row in result.get("retrieval_debug_trace",[])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")
def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("exact_top_k"), [101,501,401,201], "expected exact nearest neighbours")
    assert_equal(result.get("ann_probe_buckets"), ["backend"], "expected single ANN probe bucket")
    assert_equal(result.get("ann_candidates"), [101,401,201], "expected approximate candidates")
    assert_true(result.get("exact_top_k") != result.get("ann_candidates"), "exact and ANN outputs should differ")
    assert_equal(result.get("missed_by_ann"), [501], "expected stale_backend 501 missed by ANN")
    distance_rows = {row["content_id"]: row["distance"] for row in result.get("similarity_rows", [])}
    assert_equal(distance_rows[101], 0.0, "expected exact distance row for 101")
    assert_rejected(result, 701, "blocked_author")
    assert_true(result.get("recall_report",{}).get("ann_recall") < 1.0, "ANN recall should be less than exact recall")
    assert_retrieval_trace(result, 501, "missed_by_ann")
def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args()
    module=import_module(args.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure: print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected fake ANN to fail")
    print("PASS feed clinic proof: approximate nearest neighbour")
if __name__ == "__main__": main()
