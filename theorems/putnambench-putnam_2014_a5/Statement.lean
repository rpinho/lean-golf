import Mathlib

open Topology Filter Nat

theorem LeanGolf.putnambench.putnam_2014_a5
(P : ℕ → Polynomial ℂ)
(hP : ∀ n, P n = ∑ i ∈ Finset.Icc 1 n, i * Polynomial.X ^ (i - 1))
: ∀ (j k : ℕ), (j > 0 ∧ k > 0) → j ≠ k → IsCoprime (P j) (P k) := by sorry
