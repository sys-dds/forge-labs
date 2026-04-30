import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[101,501,601,901]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected capstone final feed [101,501,601,901]")
    assert_rejected(result,701,"blocked_author"); assert_rejected(result,102,"author_repetition"); assert_rejected(result,103,"author_repetition")
    assert_true(901 in result.get("final_feed",[]), "expected exploration 901 included in capstone final feed")
    assert_true(result.get("score_components"), "expected score components in debugging capstone")
    assert_true(result.get("diversity_adjustments"), "expected diversity adjustments in debugging capstone")
    assert_equal(result.get("offline_replay_result"), EXPECTED_FINAL, "expected offline replay to reproduce [101,501,601,901]")
    for item_id in EXPECTED_FINAL: assert_debug_trace(result,item_id)


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
