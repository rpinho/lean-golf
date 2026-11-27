import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_2_4_4 {G : Type*} [Group G] (H : Subgroup G) :
  closure ((H : Set G) \ {1}) = ⊤ := by sorry
