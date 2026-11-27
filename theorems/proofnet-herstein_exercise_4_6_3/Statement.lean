import Mathlib

open Fintype Set Real Ideal Polynomial

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.herstein_exercise_4_6_3 :
  Infinite {a : ℤ | Irreducible (X^7 + 15*X^2 - 30*X + (a : Polynomial ℚ) : Polynomial ℚ)} := by sorry
