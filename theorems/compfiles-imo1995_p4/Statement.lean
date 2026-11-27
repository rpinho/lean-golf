import Mathlib.Tactic

noncomputable section

namespace Imo1995P4

abbrev solution : ℝ := 2^997

theorem _root_.LeanGolf.compfiles.imo1995_p4 :
  IsGreatest { x₀ | ∃ x : ℕ → ℝ, x 0 = x₀ ∧ (∀ i : ℕ, 0 < x i) ∧ x 0 = x 1995
    ∧ (∀ i : ℕ, 0 < i ∧ i ≤ 1995 → x (i - 1) + (2 / x (i - 1)) = 2 * x i + (1 / x i))
  } solution := by sorry
