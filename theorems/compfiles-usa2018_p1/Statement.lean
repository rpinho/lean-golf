import Mathlib.Tactic
import Mathlib.Analysis.MeanInequalities

namespace Usa2018P1

theorem _root_.LeanGolf.compfiles.usa2018_p1 (a b c : ℝ) :
    a > 0 → b > 0 → c > 0 → a + b + c = 4 * (a * b * c) ^ ((1 : ℝ) / 3) →
    2 * (a * b + b * c + c * a) +
     4 * (min (min (a * a) (b * b)) (c * c)) ≥ a^2 + b^2 + c^2 := by sorry
