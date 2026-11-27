import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Zify

namespace Usa1994P1

theorem _root_.LeanGolf.compfiles.usa1994_p1 (a : ℕ → ℕ) (ha : ∀ i, 0 < a i)
    (h : ∀ i, a i + 1 < a (i + 1)) (n : ℕ) (hn : 1 ≤ n) :
    ∃ m : ℕ, (∑ i ∈ Finset.range n, a i) ≤ m ^ 2 ∧
      m ^ 2 < ∑ i ∈ Finset.range (n + 1), a i := by sorry
