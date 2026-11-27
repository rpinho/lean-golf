import Mathlib.Tactic

noncomputable section

open Real

namespace Imo1959P3

abbrev formedQuadratic (a b c : ℝ) : ℝ × ℝ × ℝ :=
  (a ^ 2, 2 * a ^ 2 + 4 * a * c - 2 * b ^ 2, a ^ 2 + 4 * a * c - 2 * b ^ 2 + 4 * c ^ 2)

def formedQuadraticEval (a b c : ℝ) (t : ℝ) : ℝ :=
  (formedQuadratic a b c).1 * t ^ 2 + (formedQuadratic a b c).2.1 * t +
    (formedQuadratic a b c).2.2

theorem _root_.LeanGolf.compfiles.imo1959_p3_comparison (t : ℝ) :
    formedQuadraticEval 4 2 (-1) t = 4 * (4 * t ^ 2 + 2 * t - 1) := by sorry
