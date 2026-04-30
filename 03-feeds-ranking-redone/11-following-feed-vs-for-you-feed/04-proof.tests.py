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
    assert_equal(result.get("following_feed"), [101, 401, 102], "expected Following feed [101,401,102]")
    assert_equal(result.get("for_you_feed"), [101, 501, 401, 701, 102], "expected For You feed [101,501,401,701,102]")
    assert_true(result.get("following_feed") != result.get("for_you_feed"), "expected Following and For You outputs to differ")
    assert_true(501 not in result.get("following_feed", []), "expected out-of-network Lina 501 absent from Following")
    assert_true(501 in result.get("for_you_feed", []) and 701 in result.get("for_you_feed", []), "expected For You to include Lina 501 and Maya 701")
    assert_rejected(result, 201, "muted_author")
    assert_rejected(result, 301, "blocked_author")
    assert_rejected(result, 801, "unsafe_content")
    assert_debug_trace(result, 101)
    assert_debug_trace(result, "for_you:501")
    assert_trace_contains(result, "for_you:701", "exploration")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("simulation")
    parser.add_argument("--expect-failure", action="store_true")
    parser.add_argument("--expect-success", action="store_true")
    args = parser.parse_args()
    dataset = load_json(Path(__file__).parent / "01-dataset.json")
    module = import_module(args.simulation)
    try:
        check(module.run(dataset))
    except AssertionError as exc:
        if args.expect_failure:
            print(f"PASS broken simulation failed proof as expected: {exc}")
            return
        raise
    if args.expect_failure:
        raise AssertionError("expected broken simulation to fail the product-surface proof")
    print("PASS feed clinic proof: " + Path(__file__).parent.name)

if __name__ == "__main__":
    main()
