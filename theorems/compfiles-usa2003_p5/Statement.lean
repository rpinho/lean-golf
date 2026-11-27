import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace Usa2003P5

theorem _root_.LeanGolf.compfiles.usa2003_p5 {a b c : ℝ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    (2*a+b+c)^2/(2*a^2+(b+c)^2) + (2*b+c+a)^2/(2*b^2+(c+a)^2) +
    (2*c+a+b)^2/(2*c^2+(a+b)^2) ≤ 8 := by sorry
