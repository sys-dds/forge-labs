import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace

EXPECTED_INVENTORY = [101, 201, 301, 401, 501, 601, 701]
EXPECTED_ELIGIBLE = [101, 401, 501, 701]
EXPECTED_FINAL = [101, 501, 401, 701]


def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("inventory"), EXPECTED_INVENTORY, "expected inventory to contain Ada feed items 101/201/301/401/501/601/701")
    assert_rejected(result, 201, "muted_author")
    assert_rejected(result, 301, "blocked_author")
    assert_rejected(result, 601, "unsafe_content")
    assert_equal(result.get("eligible_ids"), EXPECTED_ELIGIBLE, "expected eligible candidate IDs [101,401,501,701] after eligibility")
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected final feed [101,501,401,701] after scoring eligible items")
    for item_id in EXPECTED_FINAL:
        assert_debug_trace(result, item_id)
    impressions = [row.get("content_id") for row in result.get("feedback_events", [])]
    assert_equal(impressions, EXPECTED_FINAL, "expected feedback impression events for [101,501,401,701]")
    sources = {row["content_id"]: row["source"] for row in result.get("candidate_rows", [])}
    assert_equal(sources[101], "in_network", "expected Ben 101 candidate source in_network")
    assert_true(result.get("score_rows"), "expected score_rows for pipeline scoring")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    data = load_json(Path(__file__).parent / "01-dataset.json")
    module = import_module(args.simulation)
    try:
        check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken simulation to fail: muted Cy 201, blocked Noor 301, or unsafe Omar 601 must not survive eligibility")
    print("PASS feed clinic proof: 01-feed-pipeline-mental-model")
if __name__ == "__main__": main()
