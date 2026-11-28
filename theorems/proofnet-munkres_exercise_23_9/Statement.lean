import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

theorem LeanGolf.proofnet.munkres_exercise_23_9 {X Y : Type*}
  [TopologicalSpace X] [TopologicalSpace Y]
  (A : Set X) (B : Set Y)
  (hA : A ⊂ (Set.univ : Set X))
  (hB : B ⊂ (Set.univ : Set Y))
  (hX : IsConnected (Set.univ : Set X))
  (hY : IsConnected (Set.univ : Set Y)) :
  IsConnected ((Set.univ : Set (X × Y)) \ (A ×ˢ B)) := by sorry
