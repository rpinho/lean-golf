import Mathlib

noncomputable section

abbrev putnam_2020_a1_solution : ℕ :=
  508536

theorem LeanGolf.putnambench.putnam_2020_a1
: Set.ncard {x : ℕ | (2020 ∣ x) ∧ (Nat.log 10 x) + 1 ≤ 2020 ∧ (∃ k l, k ≥ l ∧ x = ∑ i ∈ Finset.range (k-l+1), 10 ^ (i+l))} = putnam_2020_a1_solution := by sorry
