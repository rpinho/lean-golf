import Mathlib

open Real
open scoped BigOperators
open scoped ArithmeticFunction ArithmeticFunction.Moebius

theorem LeanGolf.proofnet.ireland_rosen_exercise_2_21 {l : ℕ → ℝ}
  (hl : ∀ p n : ℕ, p.Prime → 0 < n → l (p ^ n) = Real.log p)
  (hl1 : ∀ m : ℕ, ¬ IsPrimePow m → l m = 0) :
  l = fun n ↦ (∑ d ∈ Nat.divisors n, ((ArithmeticFunction.moebius (n / d) : ℤ) : ℝ) * log d) := by sorry
