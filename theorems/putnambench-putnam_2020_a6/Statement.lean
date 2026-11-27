import Mathlib

noncomputable section

open Filter Topology Set

noncomputable abbrev putnam_2020_a6_solution : ℝ :=
  Real.pi / 4

theorem LeanGolf.putnambench.putnam_2020_a6
  (f : ℤ → (ℝ → ℝ))
  (hf : f = fun N : ℤ => fun x : ℝ =>
    ∑ n ∈ Finset.Icc 0 N, (N + 1/2 - n)/((N + 1)*(2*n + 1)) * Real.sin ((2*n + 1)*x))
  : putnam_2020_a6_solution = sSup {y | ∃ᵉ (N > 0) (x : ℝ), y = f N x} := by sorry
