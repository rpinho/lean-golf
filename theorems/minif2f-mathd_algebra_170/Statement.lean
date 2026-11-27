import Mathlib

open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_algebra_170
  (S : Finset ℤ)
  (h₀ : ∀ (n : ℤ), n ∈ S ↔ abs (n - 2) ≤ 5 + 6 / 10) :
  S.card = 11 := by sorry
