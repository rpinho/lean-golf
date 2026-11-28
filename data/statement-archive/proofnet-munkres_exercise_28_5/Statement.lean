import Mathlib

noncomputable section

open Filter Set TopologicalSpace

open Topology

noncomputable section

set_option checkBinderAnnotations false

def countably_compact (X : Type*) [TopologicalSpace X] :=
  ∀ U : ℕ → Set X,
  (∀ i, IsOpen (U i)) ∧ ((univ : Set X) ⊆ ⋃ i, U i) →
  (∃ t : Finset ℕ, (univ : Set X) ⊆ ⋃ i ∈ t, U i)

theorem LeanGolf.proofnet.munkres_exercise_28_5
  (X : Type*) [TopologicalSpace X] :
  countably_compact X ↔ ∀ (C : ℕ → Set X), (∀ n, IsClosed (C n)) ∧
  (∀ n, C n ≠ ∅) ∧ (∀ n, C n ⊆ C (n + 1)) → ∃ x, ∀ n, x ∈ C n := by sorry
