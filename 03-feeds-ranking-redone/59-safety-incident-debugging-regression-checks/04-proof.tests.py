import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape


def assert_safety_trace(result, item_id, text):
    if not any(row.get("content_id") == item_id and text in row.get("why", "") for row in result.get("safety_debug_trace", [])):
        raise AssertionError(f"expected safety_debug_trace for {item_id} to mention {text}")

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("root_causes"), ["hard_filter_disabled", "inform_label_missing", "fake_engagement_penalty_disabled", "appeal_reversal_not_applied", "safe_content_displaced"], "expected exact safety root causes")
    assert_equal(result.get("mitigations"), ["restore spam hard filter", "restore context labels", "restore fake engagement penalty", "apply appeal reversal before ranking", "rerun safe-feed regression"], "expected exact mitigations")
    assert_equal(result.get("corrected_feed"), ["post_601", "post_101", "post_501", "post_301"], "expected corrected feed")
    assert_equal(result.get("regression_checks"), {"spam_absent":True,"labels_present":True,"fake_engagement_penalized":True,"appeal_reversal_applied":True}, "expected regression checks")
    assert_rejected(result, "post_201", "spam_scam")
    assert_safety_trace(result, "incident", "root causes")


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
        raise AssertionError("expected broken safety simulation to fail")
    print("PASS feed clinic proof: Safety incident debugging regression checks")

if __name__ == "__main__":
    main()
