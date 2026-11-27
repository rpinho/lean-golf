import Mathlib

open scoped BigOperators

theorem LeanGolf.proofnet.putnam_exercise_2017_b3 (f : ℝ → ℝ) (c : ℕ → ℝ)
  (hf : f = λ x => (∑' (i : ℕ), (c i) * x^i))
  (hc : ∀ n, c n = 0 ∨ c n = 1)
  (hf1 : f (2/3) = 3/2) :
  Irrational (f (1/2)) := by sorry
