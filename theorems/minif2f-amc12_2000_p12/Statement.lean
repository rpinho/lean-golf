import Mathlib

open BigOperators Real Nat Topology Rat Finset Set

theorem LeanGolf.minif2f.amc12_2000_p12 :
  IsGreatest {x | ∃ A M C : ℕ, A + M + C = 12 ∧ x = A * M * C + A * M + M * C + A * C} 112 := by sorry
