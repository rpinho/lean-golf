import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_4_21a {X : Type*} [MetricSpace X]
  (K F : Set X) (hK : IsCompact K) (hF : IsClosed F) (hKF : Disjoint K F) :
  ∃ (δ : ℝ), δ > 0 ∧ ∀ (p q : X), p ∈ K → q ∈ F → dist p q ≥ δ := by sorry
