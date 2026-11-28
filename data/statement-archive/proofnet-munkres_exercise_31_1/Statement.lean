import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_31_1 {X : Type*} [TopologicalSpace X]
  (hX : RegularSpace X) (x y : X) :
  ∃ (U V : Set X), IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ y ∈ V ∧ closure U ∩ closure V = ∅ := by sorry
