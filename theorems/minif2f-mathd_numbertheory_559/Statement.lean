import Mathlib
import Aesop


open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_numbertheory_559
  (S: Set ℕ)
  (hS: S = {x | x % 3 = 2 ∧ ∃ y:ℕ, (y % 5 = 4 ∧ x % 10 = y % 10)}) :
  IsLeast S 14 := by sorry
