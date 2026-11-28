import Mathlib

open scoped BigOperators

theorem LeanGolf.proofnet.putnam_exercise_2020_b5 (z : Fin 4 → ℂ) (hz0 : ∀ n, ‖z n‖ < 1)
  (hz1 : ∀ n : Fin 4, z n ≠ 1) :
  3 - z 0 - z 1 - z 2 - z 3 + (z 0) * (z 1) * (z 2) * (z 3) ≠ 0 := by sorry
