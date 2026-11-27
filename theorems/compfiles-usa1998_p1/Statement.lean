import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Int.ModEq
import Mathlib.Data.Finset.Interval
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic

namespace Usa1998P1

theorem _root_.LeanGolf.compfiles.usa1998_p1
    (ab : Fin 2 → Fin 999 → Finset.Icc 1 1998)
    (hab : (ab.uncurry).Bijective)
    (habd : ∀ i : Fin 999,
              |(ab 0 i : ℤ) - (ab 1 i : ℤ)| = 1 ∨
              |(ab 0 i : ℤ) - (ab 1 i : ℤ)| = 6) :
    (∑ i : Fin 999, |(ab 0 i : ℤ) - (ab 1 i : ℤ)|) % 10 = 9 := by sorry
