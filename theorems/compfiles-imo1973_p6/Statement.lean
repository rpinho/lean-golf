import Mathlib.Tactic

namespace Imo1973P6

variable (n : ℕ) (a : Fin n → ℝ) (q : ℝ)

open Matrix

theorem _root_.LeanGolf.compfiles.imo1973_p6 (npos : 0 < n) (hq : q ∈ Set.Ioo 0 1) (apos : ∀ i, 0 < a i)
    : ∃ b : Fin n → ℝ,
      (∀ k, a k < b k)
    ∧ (∀ k, ∀ _ : k < n-1, (b ⟨k+1, by lia⟩) / (b ⟨k, by lia⟩) ∈ Set.Ioo q (1 / q))
    ∧ (∑ k, b k < (1+q) / (1-q) * ∑ k, a k) := by sorry
