import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_2_4_4 {G : Type*} [Group G] (H : Subgroup G) :
    Subgroup.closure ((H : Set G) \ {1}) = H := by sorry
