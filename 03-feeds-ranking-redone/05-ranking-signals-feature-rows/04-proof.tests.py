import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_no_duplicates, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

EXPECTED_FINAL=[501,101,601,901,801]

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("final_feed"), EXPECTED_FINAL, "expected feature-row final feed [501,101,601,901,801]")
    features=result.get("feature_rows",{})
    assert_true("701" not in features, "expected Omar 701 excluded from feature rows due negative feedback risk")
    assert_rejected(result,701,"negative_feedback_risk")
    assert_equal(features.get("501",{}).get("completion_score"), 10, "expected Lina 501 high completion feature")
    assert_equal(features.get("501",{}).get("content_type_preference"), 10, "expected Lina 501 high video preference feature")
    assert_equal(features.get("101",{}).get("relationship_strength"), 10, "expected Ben 101 strong relationship feature")
    assert_true(features.get("801",{}).get("network_suitability",99) <= 2, "expected Theo 801 poor network suitability feature")
    assert_equal(features.get("901",{}).get("exploration"), 1, "expected 901 kept as exploration feature")
    for item_id in EXPECTED_FINAL: assert_debug_trace(result,item_id)


def main():
    parser = argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args = parser.parse_args()
    data = load_json(Path(__file__).parent / "01-dataset.json"); module = import_module(args.simulation)
    try: check(module.run(data))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail the clinic-specific proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
