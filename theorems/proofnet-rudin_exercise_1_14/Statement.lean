import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_1_14
  (z : ℂ) (h : norm z = 1)
  : (norm (1 + z)) ^ 2 + (norm (1 - z)) ^ 2 = 4 := by sorry
