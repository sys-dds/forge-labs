import argparse
import sys
from pathlib import Path
SHARED_DIR = Path(__file__).resolve().parents[1] / "_shared"
sys.path.insert(0, str(SHARED_DIR))
from assertions import assert_equal, assert_rejected, assert_true
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace, assert_trace_contains

def check(result):
    validate_common_result_shape(result)
    assert_equal(result.get("creator_discovery"), ["Diya","Cy","Maya","Lina"], "expected creator discovery [Diya,Cy,Maya,Lina]")
    assert_rejected(result,"Ben","already_followed"); assert_rejected(result,"Omar","low_quality_reported"); assert_rejected(result,"Noor","blocked_creator"); assert_rejected(result,"Theo","low_relevance")
    assert_true("Cy" in result.get("creator_discovery",[]) and "Maya" in result.get("creator_discovery",[]), "expected cold-start creators Cy and Maya")
    assert_trace_contains(result,"Cy","cold-start")


def main():
    parser=argparse.ArgumentParser(); parser.add_argument("simulation"); parser.add_argument("--expect-failure", action="store_true"); parser.add_argument("--expect-success", action="store_true"); args=parser.parse_args()
    dataset=load_json(Path(__file__).parent / "01-dataset.json"); module=import_module(args.simulation)
    try: check(module.run(dataset))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}"); return
        raise
    if args.expect_failure: raise AssertionError("expected broken simulation to fail the product-surface proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)
if __name__ == "__main__": main()
