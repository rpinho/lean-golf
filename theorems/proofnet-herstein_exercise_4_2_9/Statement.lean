import Mathlib

open Fintype Set Real Ideal Polynomial
open scoped BigOperators

theorem LeanGolf.proofnet.herstein_exercise_4_2_9 {p : ℕ} (hp : Nat.Prime p) (hp1 : Odd p) :
  ∀ (a b : ℤ), (a / b : ℚ) = ∑ i ∈ Finset.range (p-1), (1 / (i + 1) : ℚ) → ↑p ∣ a := by sorry
