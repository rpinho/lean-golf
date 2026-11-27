import Mathlib

open Fintype Subgroup Set Polynomial Ideal

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.dummit_foote_exercise_4_5_1a {p : ℕ} {G : Type*} [Group G]
  {P : Subgroup G} (hP : IsPGroup p P) (H : Subgroup G)
  (hH : P ≤ H) : IsPGroup p H := by sorry
