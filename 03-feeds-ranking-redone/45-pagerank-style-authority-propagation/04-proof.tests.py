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
    assert_equal(result.get("graph_candidates"), ["post_101", "post_201", "post_301"], "expected authority-ranked posts")
    rows = {row["content_id"]: row for row in result.get("authority_rows", [])}
    assert_true(rows["post_101"]["authority_score"] > rows["post_301"]["authority_score"], "post_101 authority must beat Omar-only post")
    assert_equal(rows["post_201"]["sources"], ["backend_club"], "post_201 must expose club authority source")
    assert_rejected(result, "post_401", "spam_authority_source")
    assert_graph_trace(result, "post_101", "ben,diya")


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
    print("PASS feed clinic proof: PageRank-style authority and propagation")

if __name__ == "__main__":
    main()
