import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_4_4_9 (p : ℕ) (hp : Nat.Prime p) :
  (∃ S : Finset (ZMod p), S.card = (p-1)/2 ∧ ∃ x : ZMod p, x^2 = p) ∧
  (∃ S : Finset (ZMod p), S.card = (p-1)/2 ∧ ¬ ∃ x : ZMod p, x^2 = p) := by sorry
