import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Order.Star.Real
import Mathlib.AlgebraicTopology.SimplexCategory.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace Usa1977P5

theorem _root_.LeanGolf.compfiles.usa1977_p5
    (h k v w x y z : ℝ)
    (hh : 0 < h)
    (hv : h ≤ v ∧ v ≤ k) (hw : h ≤ w ∧ w ≤ k) (hx : h ≤ x ∧ x ≤ k)
    (hy : h ≤ y ∧ y ≤ k) (hz : h ≤ z ∧ z ≤ k) :
    (v + w + x + y + z) * (1 / v + 1 / w + 1 / x + 1 / y + 1 / z) ≤
      25 + 6 * (√(h / k) - √(k / h)) ^ 2 := by sorry
