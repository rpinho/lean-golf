import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Rat.Floor
import Mathlib

namespace Usa2006P1

theorem _root_.LeanGolf.compfiles.usa2006_p1 (p s : ℕ) (hp : p.Prime) (hs0 : 0 < s) (hs1 : s < p) :
    (∃ m n : ℕ, 0 < m ∧ m < n ∧ n < p ∧
      Int.fract ((s : ℚ) * m / p) < Int.fract ((s : ℚ) * n / p) ∧
      Int.fract ((s : ℚ) * n / p) < (s : ℚ) / p) ↔
    ¬ s ∣ p - 1 := by sorry
