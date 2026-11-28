import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_31_1 {X : Type*} [TopologicalSpace X]
    [RegularSpace X] [T1Space X]
    (x y : X) (hxy : x ≠ y) :
    ∃ U V : Set X, IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ y ∈ V ∧
      closure U ∩ closure V = (∅ : Set X) := by sorry
