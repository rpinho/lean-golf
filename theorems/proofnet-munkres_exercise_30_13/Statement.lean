import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_30_13 {X : Type*} [TopologicalSpace X]
  (h : ∃ (s : Set X), Countable s ∧ Dense s) (U : Set (Set X))
  (hU : ∀ (x y : Set X), x ∈ U → y ∈ U → x ≠ y → x ∩ y = ∅)
  (hUopen : ∀ (u : Set X), u ∈ U → IsOpen u) :
  Countable U := by sorry
