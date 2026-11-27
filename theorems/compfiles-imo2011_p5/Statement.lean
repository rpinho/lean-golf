import Mathlib.Tactic

namespace Imo2011P5

theorem _root_.LeanGolf.compfiles.imo2011_p5 (f : ℤ → ℤ)
    (f_pos : ∀ n, 0 < f n)
    (h : ∀ m n, f (m - n) ∣ f m - f n)
    : ∀ m n, f m ≤ f n → f m ∣ f n := by sorry
