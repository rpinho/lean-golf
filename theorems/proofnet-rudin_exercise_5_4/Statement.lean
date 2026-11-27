import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_5_4 {n : ℕ}
  (C : ℕ → ℝ)
  (hC : ∑ i ∈ (range (n + 1)), (C i) / (i + 1) = 0) :
  ∃ x, x ∈ (Set.Icc (0 : ℝ) 1) ∧ ∑ i ∈ range (n + 1), (C i) * (x^i) = 0 := by sorry
