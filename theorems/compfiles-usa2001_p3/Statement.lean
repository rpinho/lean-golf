import Mathlib.Tactic

namespace Usa2001P3

theorem _root_.LeanGolf.compfiles.usa2001_p3 (a b c : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hc : 0 ≤ c)
    (h : a^2 + b^2 + c^2 + a * b * c = 4) :
    0 ≤ a * b + b * c + c * a - a * b * c ∧
    a * b + b * c + c * a - a * b * c ≤ 2 := by sorry
