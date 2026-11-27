import Mathlib.Tactic

namespace Imo1977P4

theorem _root_.LeanGolf.compfiles.imo1977_p4 (f : ℝ → ℝ) (a b A B : ℝ)
    (h₀ : ∀ x, f x = 1 - a * Real.cos x - b * Real.sin x -
                     A * Real.cos (2 * x) - B * Real.sin (2 * x))
    (h₁ : ∀ x, f x ≥ 0) :
    a ^ 2 + b ^ 2 ≤ 2 ∧ A ^ 2 + B ^ 2 ≤ 1 := by sorry
