import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_23_4 {X : Type*} [TopologicalSpace X] [CofiniteTopology X]
  (s : Set X) : Infinite s → IsConnected s := by sorry
