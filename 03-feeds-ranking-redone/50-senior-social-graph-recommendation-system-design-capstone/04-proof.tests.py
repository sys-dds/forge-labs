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
    assert_equal(result.get("final_candidate_pool"), ["post_101", "maya", "post_201", "post_301", "javaconf", "post_401"], "expected senior graph capstone pool")
    assert_rejected(result, "post_501", "blocked_author")
    assert_rejected(result, "post_601", "muted_author")
    assert_equal(result.get("missing_graph_explanations"), [{"content_id":"post_701","reason":"edge_not_ingested","stage":"graph_retrieval"},{"content_id":"post_801","reason":"source_quota_overflow","stage":"graph_retrieval"}], "expected graph capstone missing explanations")
    design = result.get("graph_system_design", {})
    assert_true(isinstance(design.get("graph_schema"), dict), "graph_schema must be rich object")
    assert_true(isinstance(design.get("traversal_registry"), list), "traversal_registry must be rich list")
    assert_true(isinstance(design.get("ranking_handoff_contract"), dict), "design handoff contract must be nested")
    handoff = result.get("ranking_handoff_contract", [])
    assert_equal([row["candidate_id"] for row in handoff], ["post_101", "maya", "post_201", "post_301", "javaconf", "post_401"], "expected handoff candidate IDs")
    assert_true(all("graph_source" in row and "path" in row and "score" in row and "trace" in row for row in handoff), "handoff must include graph source path score trace")
    for item, text in [("post_101","follow_graph"),("maya","mutual_friend_graph"),("post_501","blocked_author"),("post_701","edge_not_ingested")]:
        assert_graph_trace(result, item, text)


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
    print("PASS feed clinic proof: Senior social graph recommendation system design capstone")

if __name__ == "__main__":
    main()
