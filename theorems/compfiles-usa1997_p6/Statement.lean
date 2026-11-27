import Mathlib.Algebra.Order.Archimedean.Real.Basic
import Mathlib.Data.Finset.Max
import Mathlib.Order.Interval.Finset.Nat

namespace Usa1997P6

theorem _root_.LeanGolf.compfiles.usa1997_p6 (a : ℕ → ℕ)
    (hlo : ∀ i j : ℕ, 1 ≤ i → 1 ≤ j → i + j ≤ 1997 → a i + a j ≤ a (i + j))
    (hhi : ∀ i j : ℕ, 1 ≤ i → 1 ≤ j → i + j ≤ 1997 → a (i + j) ≤ a i + a j + 1) :
    ∃ x : ℝ, ∀ n : ℕ, 1 ≤ n → n ≤ 1997 → (a n : ℤ) = ⌊(n : ℝ) * x⌋ := by sorry
