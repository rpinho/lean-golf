import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_27_4
  {X : Type*} [MetricSpace X] [ConnectedSpace X] (hX : ∃ x y : X, x ≠ y) :
  ¬ Countable (univ : Set X) := by sorry
