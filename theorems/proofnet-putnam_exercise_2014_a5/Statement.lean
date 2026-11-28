import Mathlib

open scoped BigOperators

theorem LeanGolf.proofnet.putnam_exercise_2014_a5
    (P : ℕ → Polynomial ℚ)
    (hP : ∀ n, P n = ∑ i : Fin n, (↑(i : ℕ) + 1) * Polynomial.X ^ (i : ℕ)) :
    ∀ {j k : ℕ}, 0 < j → 0 < k → j ≠ k → IsCoprime (P j) (P k) := by sorry
