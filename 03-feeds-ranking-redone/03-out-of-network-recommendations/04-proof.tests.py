import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[501,601,701,901]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected out-of-network final feed [501,601,701,901]")
    reasons={row["content_id"]:row["reasons"] for row in result.get("candidate_rows",[])}
    assert_equal(reasons.get(501), ["similar_topic_backend"], "expected Lina 501 reason similar_topic_backend")
    assert_equal(reasons.get(601), ["similar_interest_oled"], "expected Maya 601 reason similar_interest_oled")
    assert_equal(reasons.get(701), ["regional_trending"], "expected Omar 701 reason regional_trending")
    assert_equal(reasons.get(901), ["exploration_fallback"], "expected Theo 901 reason exploration_fallback")
    assert_equal([row["source_actor"] for row in result.get("candidate_rows",[])].count("Lina"), 1, "expected max one Lina item after author cap")
    assert_rejected(result,801,"blocked_or_unsafe"); assert_rejected(result,1001,"low_quality_repeat_creator"); assert_rejected(result,502,"author_cap_lina")
    for item_id in EXPECTED_FINAL: assert_debug_trace(result,item_id)


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
        raise AssertionError("expected broken simulation to fail the clinic-specific proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
