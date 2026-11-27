import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_1_18a
  (n : ℕ)
  (h : n > 1)
  (x : EuclideanSpace ℝ (Fin n)) -- R^n
  : ∃ (y : EuclideanSpace ℝ (Fin n)), y ≠ 0 ∧ (inner ℝ x y) = (0 : ℝ) := by sorry
