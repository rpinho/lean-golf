import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_25_4 {X : Type*} [TopologicalSpace X]
  [LocPathConnectedSpace X] (U : Set X) (hU : IsOpen U)
  (hcU : IsConnected U) : IsPathConnected U := by sorry
