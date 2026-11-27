import Mathlib
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Tactic

namespace Imo1961P2

theorem _root_.LeanGolf.compfiles.imo1961_p2b (a b c T : ℝ)
    (h_pos_a : 0 < a) (h_pos_b : 0 < b) (h_pos_c : 0 < c) (h_pos_T : 0 < T)
    (h_area : 16 * T^2 = (a + b + c) * (a + b - c) * (a - b + c) * (-a + b + c)) :
    a^2 + b^2 + c^2 = 4 * Real.sqrt 3 * T ↔ a = b ∧ b = c := by sorry
