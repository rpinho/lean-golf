import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_32_1 {X : Type*} [TopologicalSpace X]
  (hX : NormalSpace X) (A : Set X) (hA : IsClosed A) :
  NormalSpace {x // x ∈ A} := by sorry
