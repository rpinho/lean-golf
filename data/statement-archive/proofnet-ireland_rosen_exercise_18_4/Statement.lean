import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_18_4 {n : ℕ} (hn : ∃ x y z w : ℤ,
  x^3 + y^3 = n ∧ z^3 + w^3 = n ∧ x ≠ z ∧ x ≠ w ∧ y ≠ z ∧ y ≠ w) :
  n ≥ 1729 := by sorry
