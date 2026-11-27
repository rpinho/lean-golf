import Mathlib.Analysis.SpecialFunctions.Pow.Real

open Real

namespace Usa1997P5

variable {a b c : ℝ}

theorem _root_.LeanGolf.compfiles.usa1997_p5 (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    1 / (a^3 + b^3 + a*b*c) + 1 / (b^3 + c^3 + a*b*c) + 1 / (c^3 + a^3 + a*b*c) ≤ 1 / (a*b*c) := by sorry
