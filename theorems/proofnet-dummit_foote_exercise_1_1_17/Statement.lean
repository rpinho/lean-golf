import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_1_1_17 {G : Type*} [Group G] {x : G} {n : ℕ}
  (hxn: orderOf x = n) :
  x⁻¹ = x ^ (n - 1 : ℤ) := by sorry
