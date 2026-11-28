import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_2_1_27 {G : Type*} [Group G]
  [Fintype G] : ∃ (m : ℕ), m > 0 ∧ ∀ (a : G), a ^ m = 1 := by sorry
