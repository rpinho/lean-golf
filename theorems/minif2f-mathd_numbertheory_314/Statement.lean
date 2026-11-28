import Mathlib
import Aesop


open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_numbertheory_314
  (r n : ℕ) (h₀ : r = 1342 % 13)
  (S : Set ℕ)
  (hS: S = {x | 0 < x ∧ (∃ k:ℕ, k * 1342 = x) ∧ x % 13 < r}):
  IsLeast S 6710 := by sorry
