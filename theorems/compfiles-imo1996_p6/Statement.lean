import Mathlib.Tactic

namespace Imo1996P6

theorem _root_.LeanGolf.compfiles.imo1996_p6 {p q n : ℕ} (x : ℕ → ℤ)
    (h₁ : 0 < p) (h₂ : 0 < q) (h₃ : 0 < n) (h₄ : p + q < n)
    (h₅ : x 0 = 0) (h₆ : x n = 0)
    (h₇ : ∀ i < n, x (i + 1) - x i = p ∨ x (i + 1) - x i = -q) :
    ∃ i j : ℕ, 0 ≤ i ∧ i < j ∧ j ≤ n ∧ (i, j) ≠ (0, n) ∧ x i = x j := by sorry
