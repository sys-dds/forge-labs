import argparse, sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape

def assert_retrieval_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("retrieval_debug_trace", [])):
        raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_candidate_pool"), [101, 401, 601, 201], "expected vector similarity candidate order")
    rows = {row["content_id"]: row for row in result.get("similarity_rows", [])}
    assert_equal(rows[101]["dot_product"], 0.94, "expected 101 dot product")
    assert_equal(rows[101]["cosine_similarity"], 0.945, "expected 101 cosine similarity")
    assert_equal(rows[401]["dot_product"], 0.96, "expected 401 dot product")
    assert_equal(rows[601]["cosine_similarity"], 0.921, "expected 601 cosine similarity")
    assert_rejected(result, 501, "blocked_author")
    missed = {row["content_id"]: row["reason"] for row in result.get("missed_candidates", [])}
    assert_equal(missed, {301: "below_vector_similarity_threshold"}, "expected cooking item below vector threshold")
    assert_retrieval_trace(result, 401, "backend movies cooking")

def main():
    parser = argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args = parser.parse_args()
    module = import_module(args.simulation); data = load_json(Path(__file__).parent / "01-dataset.json")
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected likes-based embedding retrieval to fail")
    print("PASS feed clinic proof: embeddings for beginners")
if __name__ == "__main__": main()
