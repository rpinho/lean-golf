import Mathlib.Analysis.SpecialFunctions.Pow.Real

open Real

namespace Imo2001P2

variable {a b c : ℝ}

theorem _root_.LeanGolf.compfiles.imo2001_p2 (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) : 1 ≤
    a / sqrt (a ^ 2 + 8 * b * c) + b / sqrt (b ^ 2 + 8 * c * a) +
    c / sqrt (c ^ 2 + 8 * a * b) := by sorry
