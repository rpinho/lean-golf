import Mathlib

noncomputable section

open Nat

abbrev putnam_2023_a2_solution : ℕ → Set ℝ :=
  fun n => {(1 : ℝ)/(factorial n), -(1 : ℝ)/(factorial n)}

theorem LeanGolf.putnambench.putnam_2023_a2
(n : ℕ)
(hn : n > 0 ∧ Even n)
(p : Polynomial ℝ)
(hp : Polynomial.Monic p ∧ p.degree = 2*n)
(S : Set ℝ)
(hS : S = {x : ℝ | ∃ k : ℤ, x = k ∧ 1 ≤ |k| ∧ |k| ≤ n})
(hpinv : ∀ k ∈ S, p.eval (1/k) = k^2)
: {x : ℝ | x ≠ 0 ∧ p.eval (1/x) = x^2} \ S = putnam_2023_a2_solution n := by sorry
