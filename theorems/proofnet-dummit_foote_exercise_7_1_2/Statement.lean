import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_7_1_2 {R : Type*} [Ring R] {u : R}
  (hu : IsUnit u) : IsUnit (-u) := by sorry
