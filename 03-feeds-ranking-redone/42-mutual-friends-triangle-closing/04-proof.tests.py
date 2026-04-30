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
    assert_equal(result.get("people_you_may_know"), ["maya", "omar"], "expected people suggestions ranked by mutual count")
    assert_equal(result.get("mutual_rows"), [{"candidate_id":"maya","mutual_count":2,"mutuals":["ben","diya"],"paths":[["ada","ben","maya"],["ada","diya","maya"]]},{"candidate_id":"omar","mutual_count":1,"mutuals":["ben"],"paths":[["ada","ben","omar"]]}], "expected exact mutual rows")
    assert_rejected(result, "noor", "blocked_user")
    assert_equal(result.get("missed_graph_candidates"), [{"content_id":"lina","reason":"no_two_hop_path","stage":"graph_retrieval"}], "expected Lina no-path miss")
    assert_graph_trace(result, "maya", "ben,diya")
    assert_graph_trace(result, "omar", "mutual_count 1")


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
    print("PASS feed clinic proof: Mutual friends and triangle closing")

if __name__ == "__main__":
    main()
