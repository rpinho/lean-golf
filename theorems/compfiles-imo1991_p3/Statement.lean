import Mathlib.Tactic

noncomputable section

namespace Imo1991P3

abbrev solution : ℕ := 217

theorem _root_.LeanGolf.compfiles.imo1991_p3 :
    IsLeast
      {n : ℕ | ∀ T ⊆ Finset.Icc 1 280, T.card = n →
        ∃ U ⊆ T, U.card = 5 ∧ (U : Set ℕ).Pairwise Nat.Coprime}
      solution := by sorry
