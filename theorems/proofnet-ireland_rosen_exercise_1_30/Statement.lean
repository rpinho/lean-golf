import Mathlib

open Real
open scoped BigOperators

theorem LeanGolf.proofnet.ireland_rosen_exercise_1_30 (n : ℕ) (hn : 2 ≤ n) :
  ¬ ∃ a : ℤ, (Finset.range (n - 1)).sum (fun i => (1 : ℚ) / ((i : ℚ) + 2)) = (a : ℚ) := by sorry
