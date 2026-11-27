import Mathlib.Algebra.Order.Star.Real

namespace Usa2000P6

theorem _root_.LeanGolf.compfiles.usa2000_p6 (n : ℕ) (a b : Fin n → ℝ) (ha : ∀ i, 0 ≤ a i) (hb : ∀ i, 0 ≤ b i) :
    ∑ i, ∑ j, min (a i * a j) (b i * b j) ≤
    ∑ i, ∑ j, min (a i * b j) (a j * b i) := by sorry
