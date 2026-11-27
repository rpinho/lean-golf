import Mathlib

noncomputable section

abbrev putnam_1979_a2_solution : ℝ → Prop :=
  fun k : ℝ => k ≥ 0

theorem LeanGolf.putnambench.putnam_1979_a2
: ∀ k : ℝ, (∃ f : ℝ → ℝ, Continuous f ∧ ∀ x : ℝ, f (f x) = k*x^9) ↔ putnam_1979_a2_solution k := by sorry
