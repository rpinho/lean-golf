import Mathlib.Tactic

namespace Imo1976P6

theorem _root_.LeanGolf.compfiles.imo1976_p6 (u : ℕ → ℝ)
    (h₀ : u 0 = 2)
    (h₁ : u 1 = 5 / 2)
    (h₂ : ∀ n, u (n + 2) = u (n + 1) * ((u n) ^ 2 - 2) - u 1) :
      ∀ n > 0, ⌊u n⌋  = (2 : ℝ) ^ ((2^n - (-1 : ℝ) ^ n) / 3) := by sorry
