import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.artin_exercise_11_4_8 (p : ℕ) (hp : Prime p) (n : ℕ) :
  -- p ∈ ℕ can be written as p ∈ ℚ[X]
  Irreducible (X ^ n - (p : Polynomial ℚ) : Polynomial ℚ) := by sorry
