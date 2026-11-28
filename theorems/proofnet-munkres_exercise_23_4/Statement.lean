import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

set_option checkBinderAnnotations false

theorem LeanGolf.proofnet.munkres_exercise_23_4 {X : Type*} [Infinite X] :
    IsConnected (Set.univ : Set (CofiniteTopology X)) := by sorry
