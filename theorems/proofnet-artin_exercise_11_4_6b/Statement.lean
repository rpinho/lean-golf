import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd
open scoped BigOperators

theorem LeanGolf.proofnet.artin_exercise_11_4_6b {F : Type*} [Field F] [Fintype F] (hF : card F = 7) :
  Irreducible (X ^ 2 + 1 : Polynomial F) := by sorry
