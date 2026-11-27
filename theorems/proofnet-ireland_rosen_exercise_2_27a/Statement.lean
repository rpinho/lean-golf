import Mathlib

open Real

open scoped BigOperators

noncomputable section

theorem LeanGolf.proofnet.ireland_rosen_exercise_2_27a :
  ¬ Summable (λ i : {p : ℤ // Squarefree p} => (1 : ℚ) / i) := by sorry
