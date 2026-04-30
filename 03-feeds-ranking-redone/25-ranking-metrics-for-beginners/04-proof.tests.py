import argparse, sys
from pathlib import Path
SHARED_DIR=Path(__file__).resolve().parents[1]/"_shared"; sys.path.insert(0,str(SHARED_DIR))
from assertions import assert_equal, assert_true, assert_rejected
from import_simulation import import_module, load_json
from result_contract import validate_common_result_shape
from trace_helpers import assert_debug_trace

def check(result):
    validate_common_result_shape(result); assert_equal(result.get("winner"),"B","expected Variant B to win despite lower CTR")
    rows={r["variant"]:r for r in result.get("metric_rows",[])}; assert_true(rows["A"]["ctr"] > rows["B"]["ctr"],"Variant A should have higher CTR")
    assert_true(rows["A"]["hide_report_rate"] > rows["B"]["hide_report_rate"],"Variant A should have worse hide/report rate")
    assert_true(rows["B"]["completion_rate"] > rows["A"]["completion_rate"],"Variant B should have better completion")
    assert_rejected(result,"Variant A","guardrails_and_quality_worse"); assert_debug_trace(result,"B")
def main():
    p=argparse.ArgumentParser(); p.add_argument("simulation"); p.add_argument("--expect-failure",action="store_true"); p.add_argument("--expect-success",action="store_true"); a=p.parse_args(); m=import_module(a.simulation); data=load_json(Path(__file__).parent/"01-dataset.json")
    try: check(m.run(data))
    except AssertionError as e:
        if a.expect_failure: print(f"PASS broken simulation failed proof as expected: {e}"); return
        raise
    if a.expect_failure: raise AssertionError("expected CTR-only metric comparison to fail")
    print("PASS feed clinic proof: ranking metrics")
if __name__=="__main__": main()
