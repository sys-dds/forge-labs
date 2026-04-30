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
    assert_equal(result.get("graph_candidates"), ["post_101", "post_301", "post_501", "post_401"], "expected weighted random-walk order")
    assert_equal([(row["content_id"], row["path_probability"]) for row in result.get("random_walk_rows")], [("post_101",0.35),("post_301",0.24),("post_501",0.2),("post_401",0.06)], "expected exact path probability rows")
    assert_rejected(result, "post_201", "muted_author")
    assert_graph_trace(result, "post_301", "probability 0.24")
    assert_graph_trace(result, "post_501", "weighted path")


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
    print("PASS feed clinic proof: Random-walk recommendation intuition")

if __name__ == "__main__":
    main()
