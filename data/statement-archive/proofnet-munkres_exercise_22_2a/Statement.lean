import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_22_2a {X Y : Type*} [TopologicalSpace X]
  [TopologicalSpace Y] (p : X → Y) (h : Continuous p) :
  IsQuotientMap p ↔ ∃ (f : Y → X), Continuous f ∧ p ∘ f = id := by sorry
