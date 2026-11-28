import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_30_10
  {ι : Type*} [Countable ι] {X : ι → Type*} [∀ i, TopologicalSpace (X i)]
  (h : ∀ i, ∃ (s : Set (X i)), Countable s ∧ Dense s) :
  ∃ (s : Set (Π i, X i)), Countable s ∧ Dense s := by sorry
