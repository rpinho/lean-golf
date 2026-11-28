import Mathlib

open Fintype Subgroup Set Polynomial Ideal
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_4_3_26 {α : Type*} [Fintype α] (ha : Fintype.card α > 1)
  (G : Subgroup (Equiv.Perm α))
  (h_tran : ∀ a b : α, ∃ σ : G, (σ : Equiv.Perm α) a = b) :
  ∃ σ : G, ∀ a : α, (σ : Equiv.Perm α) a ≠ a := by sorry
