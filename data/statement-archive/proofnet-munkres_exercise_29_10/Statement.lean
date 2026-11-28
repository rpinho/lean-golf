import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

def K : Set ℝ := {r | ∃ n : ℕ, r = 1 / n}

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_29_10 {X : Type*}
  [TopologicalSpace X] [T2Space X] (x : X)
  (hx : ∃ U : Set X, x ∈ U ∧ IsOpen U ∧ (∃ K : Set X, U ⊂ K ∧ IsCompact K))
  (U : Set X) (hU : IsOpen U) (hxU : x ∈ U) :
  ∃ (V : Set X), IsOpen V ∧ x ∈ V ∧ IsCompact (closure V) ∧ closure V ⊆ U := by sorry
