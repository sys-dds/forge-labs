"""Small ecosystem math helpers with no clinic-specific business rules."""


def safe_divide(numerator, denominator):
    if denominator == 0:
        return 0
    return numerator / denominator


def bounded_score(value, minimum, maximum):
    return max(minimum, min(maximum, value))


def weighted_sum(parts):
    return round(sum(value * weight for value, weight in parts.values()), 2)


def stable_top_k(rows, key, k):
    return sorted(rows, key=key)[:k]


def exposure_ratio(shown, target):
    return round(safe_divide(shown, target), 2)


def compute_gap(actual, target):
    return round(target - actual, 2)


def clamp_penalty(value, minimum, maximum):
    return bounded_score(value, minimum, maximum)
