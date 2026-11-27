import Mathlib.Algebra.BigOperators.Field
import Mathlib.Algebra.BigOperators.Module
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.Star.Real

namespace Usa1994P4

theorem _root_.LeanGolf.compfiles.usa1994_p4 (x : ℕ → ℝ) (_hx : ∀ i, 0 < x i)
    (h : ∀ n : ℕ, Real.sqrt (n : ℝ) ≤ ∑ i ∈ Finset.range n, x i)
    (n : ℕ) (hn : 1 ≤ n) :
    (∑ i ∈ Finset.range n, (1 : ℝ) / (i + 1)) / 4 < ∑ i ∈ Finset.range n, (x i) ^ 2 := by sorry
