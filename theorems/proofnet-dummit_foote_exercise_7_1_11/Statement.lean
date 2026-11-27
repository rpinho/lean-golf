import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_7_1_11 {R : Type*} [Ring R] [IsDomain R]
  {x : R} (hx : x^2 = 1) : x = 1 ∨ x = -1 := by sorry
