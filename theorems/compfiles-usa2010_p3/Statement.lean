import Mathlib.Algebra.Order.Star.Real

noncomputable section

namespace Usa2010P3

abbrev answer : ℝ := ∏ k ∈ Finset.range 1005, (4 * k + 3)

theorem _root_.LeanGolf.compfiles.usa2010_p3 :
    IsGreatest {x : ℝ | ∃ a : ℕ → ℝ,
      (∀ i, i < 2010 → 0 < a i) ∧
      (∀ i j : ℕ, i < j → j < 2010 → a i * a j ≤ (i : ℝ) + 1 + ((j : ℝ) + 1)) ∧
      x = ∏ i ∈ Finset.range 2010, a i} answer := by sorry
