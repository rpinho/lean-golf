import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_1_1_34 {G : Type*} [Group G] {x : G}
  (hx_inf : orderOf x = 0) (n m : ℤ) :
  x ^ n ≠ x ^ m := by sorry
