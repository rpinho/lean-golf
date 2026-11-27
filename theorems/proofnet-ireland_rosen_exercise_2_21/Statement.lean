import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_2_21 {l : ℕ → ℝ}
  (hl : ∀ p n : ℕ, p.Prime → l (p^n) = log p )
  (hl1 : ∀ m : ℕ, ¬ IsPrimePow m → l m = 0) :
  l = λ n => ∑ d : Nat.divisors n, ArithmeticFunction.moebius (n/d) * log d  := by sorry
