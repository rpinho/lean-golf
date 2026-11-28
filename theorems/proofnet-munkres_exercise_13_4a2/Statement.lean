import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

def is_topology_c (X : Type*) (T : Set (Set X)) :=
  univ ∈ T ∧
  (∀ s t, s ∈ T → t ∈ T → s ∩ t ∈ T) ∧
  (∀ s, (∀ t ∈ s, t ∈ T) → sUnion s ∈ T)

theorem LeanGolf.proofnet.munkres_exercise_13_4a2 :
  ∃ (X I : Type*) (T : I → Set (Set X)),
  (∀ i, is_topology_c X (T i)) ∧ ¬  is_topology_c X (⋃ i : I, T i) := by sorry
