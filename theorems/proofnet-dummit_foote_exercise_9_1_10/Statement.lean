import Mathlib

open Fintype Subgroup Set Polynomial Ideal MvPolynomial
open scoped BigOperators

theorem LeanGolf.proofnet.dummit_foote_exercise_9_1_10 {f : ℕ → MvPolynomial ℕ ℤ}
    (hf : f = fun i => MvPolynomial.X (2*i) * MvPolynomial.X (2*i+1)) :
    Infinite (minimalPrimes (MvPolynomial ℕ ℤ ⧸ span (range f))) := by sorry
