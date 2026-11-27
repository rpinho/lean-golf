import Mathlib

noncomputable section

open Real

noncomputable abbrev putnam_2025_a2_solution : ℝ × ℝ :=
  (1 / π, 4 / π ^ 2)

theorem LeanGolf.putnambench.putnam_2025_a2 (a b : ℝ) :
  ((a, b) = putnam_2025_a2_solution) ↔
  (IsGreatest {a' : ℝ | ∀ x ∈ Set.Icc 0 π, a' * x * (π - x) ≤ sin x} a ∧
   IsLeast {b' : ℝ | ∀ x ∈ Set.Icc 0 π, sin x ≤ b' * x * (π - x)} b) := by sorry
