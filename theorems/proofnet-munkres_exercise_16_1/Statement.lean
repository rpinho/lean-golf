import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_16_1 {X : Type*} [TopologicalSpace X]
  (Y : Set X)
  (A : Set Y) :
  ∀ U : Set A, IsOpen U ↔ IsOpen (Subtype.val '' U) := by sorry
