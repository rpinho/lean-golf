import Mathlib

noncomputable section

open Set

abbrev putnam_1971_a2_solution : Set (Polynomial ℝ) :=
  {Polynomial.X}

theorem LeanGolf.putnambench.putnam_1971_a2
    (P : Polynomial ℝ) :
    (P.eval 0 = 0 ∧ (∀ x : ℝ, P.eval (x^2 + 1) = (P.eval x)^2 + 1)) ↔ P ∈ putnam_1971_a2_solution := by sorry
