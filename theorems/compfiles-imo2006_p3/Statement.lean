import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Tactic

noncomputable section

open Real

namespace Imo2006P3

noncomputable abbrev solution : ℝ := 9 * sqrt 2 / 32

theorem _root_.LeanGolf.compfiles.imo2006_p3 :
    IsLeast
      { M | (∀ a b c : ℝ,
              |a * b * (a ^ 2 - b ^ 2) + b * c * (b ^ 2 - c ^ 2) + c * a * (c ^ 2 - a ^ 2)| ≤
              M * (a ^ 2 + b ^ 2 + c ^ 2) ^ 2) } solution := by sorry
