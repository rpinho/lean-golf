import Mathlib.Tactic

noncomputable section

open Real

namespace Imo1959P3

abbrev formedQuadratic (a b c : ℝ) : ℝ × ℝ × ℝ :=
  (a ^ 2, 2 * a ^ 2 + 4 * a * c - 2 * b ^ 2, a ^ 2 + 4 * a * c - 2 * b ^ 2 + 4 * c ^ 2)

def formedQuadraticEval (a b c : ℝ) (t : ℝ) : ℝ :=
  (formedQuadratic a b c).1 * t ^ 2 + (formedQuadratic a b c).2.1 * t +
    (formedQuadratic a b c).2.2

theorem _root_.LeanGolf.compfiles.imo1959_p3 (a b c x : ℝ) (h : a * cos x ^ 2 + b * cos x + c = 0) :
    formedQuadraticEval a b c (cos (2 * x)) = 0 := by sorry
