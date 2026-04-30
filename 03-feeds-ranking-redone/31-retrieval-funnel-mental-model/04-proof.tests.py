import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape


def assert_retrieval_trace(result, item_id, text):
    for row in result.get("retrieval_debug_trace", []):
        if row.get("content_id") == item_id and text in row.get("why", ""):
            return
    raise AssertionError(f"expected retrieval_debug_trace for {item_id} to mention {text}")


def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_candidate_pool"), [101, 401, 501, 601, 901], "expected retrieval funnel candidate pool")
    sources = {row.get("content_id"): row.get("source") for row in result.get("retrieved_candidates", [])}
    assert_equal(sources, {101: "followed_author", 401: "group", 501: "semantic_similarity", 601: "exploration", 901: "exploration"}, "expected source label for every retrieved candidate")
    assert_rejected(result, 201, "muted_author")
    assert_rejected(result, 301, "blocked_author")
    assert_rejected(result, 801, "unsafe_content")
    missed = {row["content_id"]: row["reason"] for row in result.get("missed_candidates", [])}
    assert_equal(missed, {701: "no_retrieval_source"}, "expected 701 missed before ranking")
    for item_id, text in [(101, "followed_author"), (201, "muted_author"), (301, "blocked_author"), (701, "no_retrieval_source"), (901, "exploration")]:
        assert_retrieval_trace(result, item_id, text)
    assert_true(all("source" in row for row in result.get("retrieved_candidates", [])), "every retrieved candidate must carry a source")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    module = import_module(args.simulation)
    data = load_json(Path(__file__).parent / "01-dataset.json")
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken retrieval funnel to fail")
    print("PASS feed clinic proof: retrieval funnel mental model")
if __name__ == "__main__": main()
