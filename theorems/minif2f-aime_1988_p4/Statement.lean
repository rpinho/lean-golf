import Mathlib

open BigOperators Real Nat Topology Rat Finset Set

theorem LeanGolf.minif2f.aime_1988_p4 :
  IsLeast {n | ∃ x : Fin n → ℝ, (∀ i, abs (x i) < 1) ∧ (∑ i, abs (x i) = 19 + abs (∑ i, x i))} 20 := by sorry
