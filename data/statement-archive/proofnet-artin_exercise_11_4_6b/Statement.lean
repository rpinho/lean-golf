import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.artin_exercise_11_4_6b {F : Type*} [Field F] [Fintype F] (hF : card F = 31) :
  Irreducible (X ^ 3 - 9 : Polynomial F) := by sorry
