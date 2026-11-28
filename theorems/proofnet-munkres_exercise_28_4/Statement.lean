import Mathlib

open Filter Set TopologicalSpace
open scoped Topology

def countably_compact (X : Type*) [TopologicalSpace X] :=
  ∀ U : ℕ → Set X,
  (∀ i, IsOpen (U i)) ∧ ((univ : Set X) ⊆ ⋃ i, U i) →
  (∃ t : Finset ℕ, (univ : Set X) ⊆ ⋃ i ∈ t, U i)

def limit_point_compact_strong (X : Type*) [TopologicalSpace X] :=
  ∀ U : Set X, Infinite U → ∃ x, ClusterPt x (𝓟 (U \ {x}))

theorem LeanGolf.proofnet.munkres_exercise_28_4 {X : Type*} [TopologicalSpace X]
    (hT1 : T1Space X) : countably_compact X ↔ limit_point_compact_strong X := by sorry
