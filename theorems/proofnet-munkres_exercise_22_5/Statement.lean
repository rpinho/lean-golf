import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_22_5 {X Y : Type*} [TopologicalSpace X]
  [TopologicalSpace Y] (p : X → Y) (hp : IsOpenMap p)
  (A : Set X) (hA : IsOpen A) : IsOpenMap (p ∘ Subtype.val : A → Y) := by sorry
