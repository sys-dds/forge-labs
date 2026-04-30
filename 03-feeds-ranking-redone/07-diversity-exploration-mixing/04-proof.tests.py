import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[101,102,601,701,901]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected diverse feed [101,102,601,701,901]")
    assert_rejected(result,1001,"unsafe_content")
    assert_true(result.get("author_counts",{}).get("Ben",0) <= 2, "expected Ben at most twice")
    assert_true(result.get("topic_counts",{}).get("backend",0) <= 2, "expected backend topic at most twice")
    assert_true(901 in result.get("final_feed",[]), "expected exploration 901 included")
    assert_true(any("Ben" in note for note in result.get("diversity_adjustments",[])), "expected diversity adjustment explaining removed Ben posts")
    assert_trace_contains(result,601,"fresh movies"); assert_trace_contains(result,701,"cooking"); assert_trace_contains(result,901,"exploration")


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
