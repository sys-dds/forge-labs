import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("sent_notifications"), ["ben_posted","maya_thread"], "expected sent notifications [ben_posted,maya_thread]")
    assert_rejected(result,"ben_posted_duplicate","duplicate_notification")
    assert_rejected(result,"lina_similar_topic","quiet_hours")
    assert_rejected(result,"noor_blocked","blocked_author")
    assert_rejected(result,"omar_trending","fatigue_or_low_open_probability")
    assert_true(len(result.get("sent_notifications",[])) <= 2, "expected notification count to respect fatigue cap 2")
    assert_trace_contains(result,"ben_posted","dedupe"); assert_trace_contains(result,"maya_thread","fatigue cap")


def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args()
    data=load_json(Path(__file__).parent / "01-dataset.json"); module=import_module(args.simulation)
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail the clinic-specific proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
