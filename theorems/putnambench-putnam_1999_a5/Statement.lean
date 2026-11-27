import Mathlib

open Filter Topology Metric

theorem LeanGolf.putnambench.putnam_1999_a5
: ∃ C : ℝ, ∀ p : Polynomial ℝ, p.degree = 1999 → ‖p.eval 0‖ ≤ C * ∫ x in (-1)..1, ‖p.eval x‖ := by sorry
