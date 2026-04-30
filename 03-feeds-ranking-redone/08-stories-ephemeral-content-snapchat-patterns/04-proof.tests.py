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
    assert_equal(result.get("story_tray"), [101], "expected story tray [101]")
    assert_equal(result.get("spotlight_feed"), [701,501], "expected spotlight feed [701,501]")
    assert_rejected(result,102,"expired_story"); assert_rejected(result,201,"muted_author"); assert_rejected(result,301,"blocked_author"); assert_rejected(result,601,"language_mismatch"); assert_rejected(result,801,"reported_content")
    features={row["content_id"]:row["features"] for row in result.get("feature_rows",[])}
    assert_true(features[701]["completion_score"] > features[501]["completion_score"], "expected Maya 701 to beat Lina 501 by completion watch signal")
    assert_trace_contains(result,101,"story tray"); assert_trace_contains(result,701,"spotlight"); assert_trace_contains(result,501,"spotlight")


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
