import json
from pathlib import Path

def load_dataset(x): return x if isinstance(x,dict) else json.loads(Path(x).read_text())
def compute_experiment_delta(control,treatment): return {k:round(treatment[k]-control[k],4) for k in control}
def evaluate_primary_metric(delta): return delta["ctr"] > 0
def evaluate_safety_guardrail(treatment): return treatment["hide_report_rate"] <= 0.02
def evaluate_diversity_guardrail(treatment): return treatment["creator_diversity"] >= 4
def evaluate_retention_guardrail(control,treatment): return treatment["retention"] >= control["retention"]
def build_guardrail_failures(control,treatment):
    failures=[]
    if not evaluate_safety_guardrail(treatment): failures.append("hide_report_rate")
    if not evaluate_diversity_guardrail(treatment): failures.append("creator_diversity")
    if not evaluate_retention_guardrail(control,treatment): failures.append("retention")
    return failures
def make_launch_decision(primary_ok, failures): return "launch" if primary_ok else "do_not_launch"
def run(dataset):
    data=load_dataset(dataset); delta=compute_experiment_delta(data["control"],data["treatment"]); failures=build_guardrail_failures(data["control"],data["treatment"]); decision=make_launch_decision(evaluate_primary_metric(delta),failures)
    return {"inventory":["control","treatment"],"rejected_items":[{"content_id":"treatment","reason":"guardrail_failures","stage":"experiment_review"}],"experiment_delta":delta,"guardrail_failures":failures,"launch_decision":decision,"debug_trace":[{"content_id":"treatment","included":decision=="launch","why":f"ctr_delta {delta['ctr']} failures {failures}"}]}
