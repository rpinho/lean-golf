import Mathlib

open Filter Set TopologicalSpace

open Topology

noncomputable section

theorem LeanGolf.proofnet.munkres_exercise_13_3b : ¬ ∀ X : Type, ∀s : Set (Set X),
  (∀ t : Set X, t ∈ s → (Set.Infinite tᶜ ∨ t = ∅ ∨ t = ⊤)) →
  (Set.Infinite (⋃₀ s)ᶜ ∨ (⋃₀ s) = ∅ ∨ (⋃₀ s) = ⊤) := by sorry
