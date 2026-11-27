import Mathlib

open Function Fintype Subgroup Ideal Polynomial Submodule Zsqrtd

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.artin_exercise_2_3_2 {G : Type*} [Group G] (a b : G) :
  ∃ g : G, b* a = g * a * b * g⁻¹ := by sorry
