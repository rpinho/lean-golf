import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd
open scoped BigOperators

theorem LeanGolf.proofnet.artin_exercise_11_4_8 (p : ℕ) (hp : Prime p) (n : ℕ) (hn : n > 0) :
  Irreducible (X ^ n - (p : Polynomial ℚ) : Polynomial ℚ) := by sorry
