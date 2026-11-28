import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_4_5_25 {p : ℕ} (hp : Nat.Prime p) :
  Irreducible (∑ i ∈ Finset.range p, X ^ i : Polynomial ℚ) := by sorry
