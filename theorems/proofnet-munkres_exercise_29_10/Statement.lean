import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_29_10 {X : Type*}
  [TopologicalSpace X] [T2Space X] (x : X)
  (hx : ∃ U : Set X, x ∈ U ∧ IsOpen U ∧ (∃ K : Set X, U ⊆ K ∧ IsCompact K))
  (U : Set X) (hU : IsOpen U) (hxU : x ∈ U) :
  ∃ (V : Set X), IsOpen V ∧ x ∈ V ∧ IsCompact (closure V) ∧ closure V ⊆ U := by sorry
