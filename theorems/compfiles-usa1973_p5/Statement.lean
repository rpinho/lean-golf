import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Positivity.Core
import Mathlib.Tactic.Ring

namespace Usa1973P5

theorem _root_.LeanGolf.compfiles.usa1973_p5 (p q r : ℕ) (hp : p.Prime) (hq : q.Prime) (hr : r.Prime)
    (hpq : p ≠ q) (hqr : q ≠ r) (hpr : p ≠ r) :
    ¬∃ (m n : ℤ) (d : ℝ),
      (q : ℝ) ^ ((1 : ℝ) / 3) = (p : ℝ) ^ ((1 : ℝ) / 3) + (m : ℝ) * d ∧
      (r : ℝ) ^ ((1 : ℝ) / 3) = (p : ℝ) ^ ((1 : ℝ) / 3) + (n : ℝ) * d := by sorry
