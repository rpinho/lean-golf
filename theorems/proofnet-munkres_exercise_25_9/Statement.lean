import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_25_9 {G : Type*} [TopologicalSpace G] [Group G]
  [IsTopologicalGroup G] (C : Set G) (h : C = connectedComponent 1) :
  ∃ C' : Subgroup G, C' = C ∧ C'.Normal := by sorry
