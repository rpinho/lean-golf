import Mathlib.Tactic

noncomputable section

namespace Imo2006P4

abbrev solution : Set (ℤ × ℤ) := {(0, 2), (0, -2), (4, 23), (4, -23)}

theorem _root_.LeanGolf.compfiles.imo2006_p4 :
    {(x, y) : ℤ × ℤ | 1 + (2 : ℝ) ^ x + 2 ^ (2 * x + 1) = y ^ 2} =
    solution := by sorry
