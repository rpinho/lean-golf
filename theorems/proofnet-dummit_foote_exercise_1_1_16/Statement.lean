import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_1_1_16 {G : Type*} [Group G]
  (x : G) : x ^ 2 = 1 ↔ (orderOf x = 1 ∨ orderOf x = 2) := by sorry
