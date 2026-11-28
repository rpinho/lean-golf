import Mathlib

open Topology Filter Real Complex TopologicalSpace Finset

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.rudin_exercise_2_19a {X : Type*} [MetricSpace X]
  (A B : Set X) (hA : IsClosed A) (hB : IsClosed B) (hAB : Disjoint A B) :
  SeparatedNhds A B := by sorry
