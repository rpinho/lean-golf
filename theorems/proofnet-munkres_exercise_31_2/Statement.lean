import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_31_2 {X : Type*}
  [TopologicalSpace X] [NormalSpace X] {A B : Set X}
  (hA : IsClosed A) (hB : IsClosed B) (hAB : Disjoint A B) :
  ∃ (U V : Set X), IsOpen U ∧ IsOpen V ∧ A ⊆ U ∧ B ⊆ V ∧ closure U ∩ closure V = ∅ := by sorry
