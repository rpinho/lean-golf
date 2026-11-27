import Mathlib

noncomputable section

open Polynomial Filter Topology ProbabilityTheory MeasureTheory

noncomputable abbrev putnam_1976_b5_solution : ℕ → Polynomial ℤ :=
  fun n => C (Nat.factorial n)

theorem LeanGolf.putnambench.putnam_1976_b5
: ∀ n : ℕ, ∑ k ∈ Finset.range (n + 1), C ((-(1 : ℤ))^k * Nat.choose n k) * (X - (C (k : ℤ)))^n = putnam_1976_b5_solution n := by sorry
