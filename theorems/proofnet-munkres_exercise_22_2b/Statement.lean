import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_22_2b {X : Type*} [TopologicalSpace X]
  {A : Set X} (r : X → A) (hr : Continuous r) (h : ∀ x : A, r x = x) :
  IsQuotientMap r := by sorry
