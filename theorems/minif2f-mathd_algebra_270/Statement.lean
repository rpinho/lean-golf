import Mathlib

open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_algebra_270
  (f : ℝ → ℝ)
  (h₀ : ∀ x, x ≠ -2 -> f x = 1 / (x + 2)) :
  f (f 1) = 3/7 := by sorry
