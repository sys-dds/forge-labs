"""Tiny safety helpers shared by deterministic feed safety clinics."""


def safe_divide(numerator, denominator):
    if denominator == 0:
        return 0.0
    return numerator / denominator


def bounded_score(value, minimum, maximum):
    return max(minimum, min(maximum, value))


def weighted_sum(parts):
    return sum(value * weight for value, weight in parts)


def classify_treatment(policy_label, risk_score):
    if policy_label in {"spam_scam", "harassment_violation", "malware", "blocked_author"} or risk_score >= 90:
        return "remove"
    if risk_score >= 70:
        return "review"
    if risk_score >= 50:
        return "reduce"
    if policy_label in {"context_needed", "borderline_medical", "borderline_claim"}:
        return "inform"
    return "allow"


def build_decision_trace(content_id, decision, evidence):
    return {"content_id": content_id, "why": f"{decision} from {evidence}"}


def stable_top_k(rows, key, k):
    return sorted(rows, key=key)[:k]
