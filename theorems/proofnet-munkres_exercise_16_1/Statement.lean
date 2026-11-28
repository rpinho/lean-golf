import Mathlib

open Filter Set TopologicalSpace Topology
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_16_1 {X : Type*} [TopologicalSpace X]
    (Y : Set X) (A : Set Y) :
    IsInducing (fun a : A => (a : X)) := by sorry
