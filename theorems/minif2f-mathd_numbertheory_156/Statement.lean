import Mathlib
import Aesop


open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_numbertheory_156
  (S : Set ℕ)
  (hS : S = {x | ∃ n, 0 < n ∧ x = Nat.gcd (n + 7) (2 * n + 1)}) :
  IsGreatest S 13 := by sorry
