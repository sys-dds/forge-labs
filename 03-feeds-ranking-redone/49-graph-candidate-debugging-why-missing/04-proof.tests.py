import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape


def assert_graph_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("graph_debug_trace", [])):
        raise AssertionError(f"expected graph_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_candidate_pool"), ["post_101", "maya", "backend_club", "post_701"], "expected graph debug candidate pool")
    expected = [{"content_id":"post_201","reason":"edge_not_ingested","stage":"graph_retrieval"},{"content_id":"post_301","reason":"edge_expired","stage":"graph_retrieval"},{"content_id":"post_401","reason":"blocked_author_path","stage":"graph_retrieval"},{"content_id":"post_501","reason":"weak_community_affinity","stage":"graph_retrieval"},{"content_id":"post_601","reason":"source_quota_overflow","stage":"graph_retrieval"}]
    assert_equal(result.get("missing_graph_explanations"), expected, "expected exact graph missing explanations")
    assert_true(all(row["reason"] != "low_score" for row in result.get("missing_graph_explanations", [])), "graph missing explanations must not say low_score")
    assert_true(all(row["stage"] == "graph_retrieval" for row in result.get("missing_graph_explanations", [])), "every missing candidate must stay in graph_retrieval stage")
    assert_graph_trace(result, "post_201", "edge_not_ingested")
    assert_graph_trace(result, "post_701", "retrieved")


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
        raise AssertionError("expected broken graph simulation to fail")
    print("PASS feed clinic proof: Graph candidate debugging why missing")

if __name__ == "__main__":
    main()
