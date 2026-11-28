import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_4_5_17 {G : Type*} [Fintype G] [Group G]
  (hG : card G = 105) :
  (∃ (P : Sylow 5 G), P.Normal) ∧ (∃ (P : Sylow 7 G), P.Normal) := by sorry
