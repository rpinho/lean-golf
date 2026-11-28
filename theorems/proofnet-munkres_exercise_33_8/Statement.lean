import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

abbrev I : Set ℝ := Icc 0 1

theorem LeanGolf.proofnet.munkres_exercise_33_8
  (X : Type*) [TopologicalSpace X] [CompletelyRegularSpace X]
  (A B : Set X) (hA : IsClosed A) (hB : IsClosed B)
  (hAB : Disjoint A B) (hAc : IsCompact A)
  (hAn : A.Nonempty) (hBn : B.Nonempty) :
  ∃ (f : X → I), Continuous f ∧ f '' A = {0} ∧ f '' B = {1} := by sorry
