import Mathlib.Algebra.Order.Star.Real

namespace Usa2009P4

theorem _root_.LeanGolf.compfiles.usa2009_p4 {n : ℕ} (hn : 2 ≤ n) (a : Fin n → ℝ) (ha : ∀ i, 0 < a i)
    (h : (∑ i, a i) * (∑ i, 1 / a i) ≤ ((n : ℝ) + 1 / 2) ^ 2) :
    (Finset.univ.image a).max' (Finset.image_nonempty.mpr ⟨⟨0, by lia⟩, Finset.mem_univ _⟩)
      ≤ 4 * (Finset.univ.image a).min'
          (Finset.image_nonempty.mpr ⟨⟨0, by lia⟩, Finset.mem_univ _⟩) := by sorry
