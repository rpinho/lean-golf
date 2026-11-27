import Mathlib

noncomputable section

abbrev putnam_2020_a2_solution : ℕ → ℕ :=
  fun k ↦ 4 ^ k

theorem LeanGolf.putnambench.putnam_2020_a2
(k : ℕ)
: (∑ j ∈ Finset.Icc 0 k, 2 ^ (k - j) * Nat.choose (k + j) j = putnam_2020_a2_solution k) := by sorry
