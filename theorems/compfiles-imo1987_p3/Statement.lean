import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Order.Star.Real
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity.Basic

namespace Imo1987P3

theorem _root_.LeanGolf.compfiles.imo1987_p3 {n : ℕ} (hn : 0 < n) (x : Fin n → ℝ) (hx : ∑ i, x i ^ 2 = 1)
    {k : ℕ} (hk : 2 ≤ k) :
    ∃ a : Fin n → ℤ, (∀ i, |a i| ≤ (k : ℤ) - 1) ∧ (∃ i, a i ≠ 0) ∧
      |∑ i, (a i : ℝ) * x i| ≤ ((k : ℝ) - 1) * Real.sqrt n / ((k : ℝ) ^ n - 1) := by sorry
