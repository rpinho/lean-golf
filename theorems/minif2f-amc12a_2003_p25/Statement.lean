import Mathlib

open BigOperators Real Nat Topology Rat Set

theorem LeanGolf.minif2f.amc12a_2003_p25 :
    {a : ℝ | ∃
      (b : ℝ) (f : ℝ → ℝ) (h₀ : 0 < b)
      (h₁ : ∀ x, f x = Real.sqrt (a * x ^ 2 + b * x)),
      {x | 0 ≤ a * x ^ 2 + b * x} = f '' {x | 0 ≤ a * x ^ 2 + b * x}}.encard = (2) := by
  sorry
