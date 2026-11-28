import Mathlib

open Filter Set TopologicalSpace Topology

theorem LeanGolf.proofnet.munkres_exercise_22_2a {X Y : Type*} [TopologicalSpace X]
  [TopologicalSpace Y] (p : X → Y) (h : Continuous p) :
  (∃ (f : Y → X), Continuous f ∧ p ∘ f = id) → IsQuotientMap p := by sorry
