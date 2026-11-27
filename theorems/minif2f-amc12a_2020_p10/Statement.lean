import Mathlib

open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.amc12a_2020_p10
  (n : ℕ)
  (h₀ : 1 < n)
  (h₁ : Real.logb 2 (Real.logb 16 n) = Real.logb 4 (Real.logb 4 n)) :
  (Nat.digits 10 n).sum = 13 := by sorry
