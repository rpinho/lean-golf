import Mathlib

namespace Imo1984P1

theorem _root_.LeanGolf.compfiles.imo1984_p1  (x y z : ℝ)
  (h₀ : 0 ≤ x ∧ 0 ≤ y ∧ 0 ≤ z)
  (h₁ : x + y + z = 1) :
    0 ≤ x * y + y * z + z * x - 2 * x * y * z ∧ x * y + y * z + z * x - 2 * x * y * z ≤
      (7:ℝ) / 27 := by sorry
