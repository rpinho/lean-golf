import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.PSeries

namespace Usa2015P6

theorem _root_.LeanGolf.compfiles.usa2015_p6 {lam : ℝ} (hlam : 0 < lam ∧ lam < 1) (A : ℕ → ℕ)
    (hA : ∀ n : ℕ, ∑ m ∈ Finset.Icc 1 n, (A m : ℝ) ≤ lam * n) :
    Set.Infinite
      {n : ℕ | ∑ m ∈ Finset.Icc 1 n, m * (A m : ℝ) ≤ lam * n * (n + 1) / 2} := by sorry
