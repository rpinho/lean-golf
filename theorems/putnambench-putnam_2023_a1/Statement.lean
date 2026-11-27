import Mathlib

noncomputable section

open Nat

abbrev putnam_2023_a1_solution : ℕ :=
  18

theorem LeanGolf.putnambench.putnam_2023_a1
  (f : ℕ → ℝ → ℝ)
  (hf : ∀ n > 0, f n = fun x : ℝ => ∏ i ∈ Finset.Icc 1 n, Real.cos (i * x)) :
  IsLeast {n | 0 < n ∧ |iteratedDeriv 2 (f n) 0| > 2023} putnam_2023_a1_solution := by sorry
