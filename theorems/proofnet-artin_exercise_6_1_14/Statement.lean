import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.artin_exercise_6_1_14 (G : Type*) [Group G]
  (hG : IsCyclic $ G ⧸ (center G)) :
  center G = ⊤  := by sorry
