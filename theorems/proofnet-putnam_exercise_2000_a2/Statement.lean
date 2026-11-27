import Mathlib

open scoped BigOperators

theorem LeanGolf.proofnet.putnam_exercise_2000_a2 :
  ∀ N : ℕ, ∃ n : ℕ, n > N ∧ ∃ i : Fin 6 → ℕ, n = (i 0)^2 + (i 1)^2 ∧
  n + 1 = (i 2)^2 + (i 3)^2 ∧ n + 2 = (i 4)^2 + (i 5)^2 := by sorry
