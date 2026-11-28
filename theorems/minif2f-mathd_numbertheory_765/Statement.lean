import Mathlib
import Aesop


open BigOperators Real Nat Topology Rat

theorem LeanGolf.minif2f.mathd_numbertheory_765
  (S : Set ℤ)
  (hS : S = {x | x < 0 ∧ (24 * x) ≡ 15 [ZMOD 1199]}) :
  IsGreatest S (-449:ℤ) := by sorry
