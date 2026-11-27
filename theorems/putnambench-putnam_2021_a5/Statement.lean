import Mathlib

noncomputable section

open Filter Topology

abbrev putnam_2021_a5_solution : Set ℕ :=
  {j : ℕ | ¬(42 ∣ j) ∧ ¬(46 ∣ j)}

theorem LeanGolf.putnambench.putnam_2021_a5
  (j : ℕ)
  (A : Finset ℕ)
  (S : ℕ → ℕ)
  (hA : A = {n | 1 ≤ n ∧ n ≤ 2021 ∧ Nat.gcd n 2021 = 1})
  (hS : ∀ j' : ℕ, S j' = ∑ n ∈ A, n ^ j') :
  (2021 ∣ S j) ↔ j ∈ putnam_2021_a5_solution := by sorry
