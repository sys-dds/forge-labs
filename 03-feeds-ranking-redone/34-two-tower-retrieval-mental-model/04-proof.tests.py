import argparse, sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"; sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("retrieval_debug_trace", [])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")
def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("user_embeddings", {}).get("ada"), [0.9,0.8,0.1], "expected Ada user tower embedding")
    assert_equal(result.get("user_embeddings", {}).get("ben"), [0.1,0.2,0.9], "expected Ben user tower embedding")
    assert_equal(result.get("ada_candidates"), [301,101,501], "expected Ada backend/feed candidates")
    assert_equal(result.get("ben_candidates"), [201], "expected Ben movie candidate")
    assert_true(result.get("ada_candidates") != result.get("ben_candidates"), "Ada and Ben pools must differ")
    rows = {(row["user_id"], row["item_id"]): row["score"] for row in result.get("similarity_rows", [])}
    assert_equal(rows[("ada",301)], 1.54, "expected Ada 301 pair score")
    assert_equal(rows[("ben",201)], 0.95, "expected Ben 201 pair score")
    assert_rejected(result, 601, "blocked_author")
    assert_retrieval_trace(result, 301, "ada pair score")
def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args()
    module=import_module(args.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure: print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected same-pool two-tower retrieval to fail")
    print("PASS feed clinic proof: two tower retrieval")
if __name__ == "__main__": main()
