import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_2_24 {X : Type*} [MetricSpace X]
  (hX : ∀ (A : Set X), Infinite A → ∃ (x : X), x ∈ closure A) :
  SeparableSpace X := by sorry
