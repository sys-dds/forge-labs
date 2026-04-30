import argparse, sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("retrieval_debug_trace", [])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("lexical_matches"), [101, 301, 601, 701], "expected lexical matches before eligibility")
    assert_equal(result.get("semantic_matches"), [101, 201, 401, 601, 701], "expected semantic matches before eligibility")
    assert_true(result.get("lexical_matches") != result.get("semantic_matches"), "lexical and semantic retrieval should differ")
    assert_equal(result.get("final_candidate_pool"), [101, 601, 201, 401], "expected merged lexical semantic pool")
    assert_rejected(result, 301, "language_trap_javascript")
    assert_rejected(result, 501, "query_mismatch")
    assert_rejected(result, 701, "blocked_author")
    assert_retrieval_trace(result, 201, "semantic_topic_match")
    assert_retrieval_trace(result, 401, "semantic_topic_match")
    assert_true(any(row.get("source") == "lexical + semantic" and row.get("content_id") == 101 for row in result.get("retrieved_candidates", [])), "101 should preserve lexical plus semantic source")

def main():
    parser = argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args = parser.parse_args()
    module = import_module(args.simulation); data = load_json(Path(__file__).parent / "01-dataset.json")
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected lexical-only retrieval to fail")
    print("PASS feed clinic proof: lexical vs semantic retrieval")
if __name__ == "__main__": main()
