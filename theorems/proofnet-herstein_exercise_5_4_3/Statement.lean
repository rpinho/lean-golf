import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_5_4_3 {a : ℂ}
    (ha : a ^ 5 + (Real.sqrt 2 : ℂ) * a ^ 3 + (Real.sqrt 5 : ℂ) * a ^ 2 +
      (Real.sqrt 7 : ℂ) * a + (Real.sqrt 11 : ℂ) = 0) :
    ∃ q : Polynomial ℚ, q ≠ 0 ∧ q.natDegree ≤ 80 ∧
      Polynomial.aeval a q = 0 := by sorry
