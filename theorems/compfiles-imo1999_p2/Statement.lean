import Mathlib.Tactic

noncomputable section

namespace Imo1999P2

noncomputable abbrev C : ℝ := 1 / 8

theorem _root_.LeanGolf.compfiles.imo1999_p2 (n : ℕ) (hn : 2 ≤ n) :
    IsLeast
      {c : ℝ | ∀ x : Fin n → ℝ, (∀ i, 0 ≤ x i) →
        ∑ i, ∑ j ∈ Finset.Ioi i, x i * x j * ((x i) ^ 2 + (x j) ^ 2) ≤
          c * (∑ i, x i) ^ 4}
      C := by sorry
