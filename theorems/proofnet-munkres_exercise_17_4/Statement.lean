import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_17_4 {X : Type*} [TopologicalSpace X]
  (U A : Set X) (hU : IsOpen U) (hA : IsClosed A) :
  IsOpen (U \ A) ∧ IsClosed (A \ U) := by sorry
