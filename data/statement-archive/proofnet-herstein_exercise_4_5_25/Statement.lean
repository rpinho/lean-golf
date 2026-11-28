import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_4_5_25 {p : ℕ} (hp : Nat.Prime p) :
  Irreducible (∑ i : Finset.range p, X ^ p : Polynomial ℚ) := by sorry
