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
    assert_equal(result.get("graph_candidates"), ["post_101", "maya"], "expected directed follow plus shared-group graph candidates")
    assert_rejected(result, "post_201", "muted_author")
    assert_rejected(result, "post_301", "blocked_author")
    assert_equal(result.get("missed_graph_candidates"), [{"content_id":"cy","reason":"muted_edge_exclusion","stage":"graph_retrieval"},{"content_id":"noor","reason":"blocked_edge_exclusion","stage":"graph_retrieval"}], "expected muted and blocked graph misses")
    assert_true("post_201" not in result.get("graph_candidates", []), "muted Cy content must not be a graph candidate")
    assert_true(any(row.get("edge_type") == "friend" for row in result.get("friend_edges", [])), "friend/group edges are separate from follow edges")
    assert_graph_trace(result, "post_101", "follow edge")
    assert_graph_trace(result, "maya", "member edge")


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
    print("PASS feed clinic proof: Social graph data model")

if __name__ == "__main__":
    main()
