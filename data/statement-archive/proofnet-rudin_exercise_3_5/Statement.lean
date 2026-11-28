import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_3_5
  (a b : ℕ → ℝ)
  (h : limsup a + limsup b ≠ 0) :
  limsup (λ n => a n + b n) ≤ limsup a + limsup b := by sorry
