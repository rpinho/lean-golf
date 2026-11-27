import Mathlib.Algebra.Order.Star.Real
import Mathlib.Algebra.Polynomial.Derivative

namespace Usa1988P2

open Polynomial

theorem _root_.LeanGolf.compfiles.usa1988_p2 (a b c r s t : ℝ) (hrs : s ≤ r) (hst : t ≤ s)
    (hroots : (X - C r) * (X - C s) * (X - C t)
      = X ^ 3 + C a * X ^ 2 + C b * X + C c) :
    0 ≤ a ^ 2 - 3 * b ∧ Real.sqrt (a ^ 2 - 3 * b) ≤ r - t := by sorry
