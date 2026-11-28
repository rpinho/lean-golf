import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_34_9
  (X : Type*) [TopologicalSpace X] [CompactSpace X]
  (X1 X2 : Set X) (hX1 : IsClosed X1) (hX2 : IsClosed X2)
  (hX : X1 ∪ X2 = univ) (hX1m : MetrizableSpace X1)
  (hX2m : MetrizableSpace X2) : MetrizableSpace X := by sorry
