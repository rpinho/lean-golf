import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Star

namespace Usa1999P4

theorem _root_.LeanGolf.compfiles.usa1999_p4 (n : ℕ) (hn : 3 < n) (a : Fin n → ℝ)
    (hsum : (n : ℝ) ≤ ∑ i, a i) (hsq : (n : ℝ) ^ 2 ≤ ∑ i, (a i) ^ 2) :
    ∃ i, 2 ≤ a i := by sorry
