import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.MeanInequalities

open Real

namespace Usa2011P1

variable {a b c : ℝ}

theorem _root_.LeanGolf.compfiles.usa2011_p1 (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (h : a ^ 2 + b ^ 2 + c ^ 2 + (a + b + c) ^ 2 ≤ 4) :
    3 ≤ (a * b + 1) / (a + b) ^ 2 + (b * c + 1) / (b + c) ^ 2 + (c * a + 1) / (c + a) ^ 2 := by sorry
