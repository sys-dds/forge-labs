"""Tiny scoring helpers used by clinic-specific simulations."""


def safe_divide(numerator, denominator):
    if denominator == 0:
        return 0
    return numerator / denominator


def normalise(value, max_value):
    return safe_divide(value, max_value)


def apply_decay(score, age_hours):
    return score / (1 + max(age_hours, 0) / 24)
