import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_1_12 (n : ℕ) (f : ℕ → ℂ) :
  norm (∑ i ∈ range n, f i) ≤ ∑ i ∈ range n, norm (f i) := by sorry
