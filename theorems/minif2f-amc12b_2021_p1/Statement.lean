import Mathlib

open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.amc12b_2021_p1
  (S : Finset ℤ)
  (h₀ : ∀ (x : ℤ), x ∈ S ↔ ↑(abs x) < 3 * Real.pi):
  S.card = 19 := by sorry
