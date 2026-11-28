import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_30_13 {X : Type*} [TopologicalSpace X]
  (h : ∃ (s : Set X), Countable s ∧ Dense s) (U : Set (Set X))
  (hU : ∀ (x y : Set X), x ∈ U → y ∈ U → x ≠ y → x ∩ y = ∅) :
  Countable U := by sorry
