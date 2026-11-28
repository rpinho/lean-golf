import Mathlib

open BigOperators Real Nat Topology Rat Set

theorem LeanGolf.minif2f.imo_2006_p3 :
    IsLeast {M : ℝ | ∀ a b c : ℝ,
      abs (a * b * (a ^ 2 - b ^ 2) + b * c * (b ^ 2 - c ^ 2) + c * a * (c ^ 2 - a ^ 2)) ≤
        M * (a ^ 2 + b ^ 2 + c ^ 2) ^ 2}
      (9 * Real.sqrt 2 / 32) := by
  sorry
