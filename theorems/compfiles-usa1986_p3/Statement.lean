import Mathlib.Algebra.GCDMonoid.Nat
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Nat.Prime.Defs
import Mathlib.Data.ZMod.Defs
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.LinearCombination

noncomputable section

namespace Usa1986P3

abbrev solution : ℕ := 337

theorem _root_.LeanGolf.compfiles.usa1986_p3 :
    IsLeast {n : ℕ | 1 < n ∧ ∃ m, ∑ i ∈ Finset.range n, (i+1)^2 = n * m^2}
      solution := by sorry
