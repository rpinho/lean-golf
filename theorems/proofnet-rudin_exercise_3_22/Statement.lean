import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset
open scoped BigOperators

theorem LeanGolf.proofnet.rudin_exercise_3_22 (X : Type*) [MetricSpace X] [CompleteSpace X] [Nonempty X]
  (G : ℕ → Set X) (hG : ∀ n, IsOpen (G n) ∧ Dense (G n)) :
  ∃ x, ∀ n, x ∈ G n := by sorry
