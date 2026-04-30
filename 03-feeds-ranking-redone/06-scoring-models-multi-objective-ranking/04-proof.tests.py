import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[501,101,601,901,701]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected multi-objective order [501,101,601,901,701]")
    comps=result.get("score_components",{})
    assert_equal(comps.get("501",{}).get("completion_score"), 23.75, "expected Lina 501 completion component 23.75")
    assert_equal(comps.get("101",{}).get("comment_score"), 17.5, "expected Ben 101 comment component 17.5")
    assert_equal(comps.get("601",{}).get("share_score"), 15.0, "expected Maya 601 share component 15.0")
    assert_equal(comps.get("701",{}).get("hide_penalty"), 0.8, "expected Omar 701 visible hide risk penalty 0.8")
    assert_equal(comps.get("901",{}).get("exploration_bonus"), 4, "expected 901 exploration bonus 4")
    for item_id in EXPECTED_FINAL: assert_trace_contains(result,item_id,"score explanation")


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
