import Mathlib.Tactic

namespace Imo1976P5

theorem _root_.LeanGolf.compfiles.imo1976_p5 (n : ℕ) (hn : 0 < n) (a : Fin n → Fin (2 * n) → ℤ)
    (ha : ∀ i j, a i j = 0 ∨ a i j = 1 ∨ a i j = -1) :
    ∃ x : Fin (2 * n) → ℤ,
      (∀ j, |x j| ≤ 2 * (n : ℤ)) ∧ (∃ j, x j ≠ 0) ∧
        ∀ i, ∑ j, a i j * x j = 0 := by sorry
