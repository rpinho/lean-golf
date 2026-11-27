import Mathlib

noncomputable section

open Polynomial Filter Topology Real Set Nat

abbrev putnam_2016_a1_solution : ℕ :=
  8

theorem LeanGolf.putnambench.putnam_2016_a1 :
  IsLeast {j : ℕ | 0 < j ∧ ∀ P : ℤ[X], ∀ k : ℤ, 2016 ∣ (derivative^[j] P).eval k} putnam_2016_a1_solution := by sorry
