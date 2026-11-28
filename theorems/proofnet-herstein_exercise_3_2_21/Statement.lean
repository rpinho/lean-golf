import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_3_2_21 {α : Type*} {σ τ : Equiv.Perm α}
  (h1 : ∀ a : α, ¬(σ a ≠ a ∧ τ a ≠ a)) (h2 : τ * σ = 1) :
  σ = 1 ∧ τ = 1 := by sorry
