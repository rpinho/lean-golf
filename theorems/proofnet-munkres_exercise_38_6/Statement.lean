import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

abbrev I : Set ℝ := Icc 0 1

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_38_6 {X : Type*}
  (X : Type*) [TopologicalSpace X] [RegularSpace X]
  (h : ∀ x A, IsClosed A ∧ ¬ x ∈ A →
  ∃ (f : X → I), Continuous f ∧ f x = (1 : I) ∧ f '' A = {0}) :
  IsConnected (univ : Set X) ↔ IsConnected (univ : Set (StoneCech X)) := by sorry
