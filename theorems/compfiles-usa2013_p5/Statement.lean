import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Nat.Digits.Defs
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.ZMod.Units
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.GCD
import Mathlib.Tactic.NormNum.Prime
import Mathlib.Tactic.Ring

namespace Usa2013P5

theorem _root_.LeanGolf.compfiles.usa2013_p5 (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    ∃ c : ℕ, 0 < c ∧ ∀ d ∈ Finset.Icc 1 9,
      (Nat.digits 10 (c * m)).count d = (Nat.digits 10 (c * n)).count d := by sorry
