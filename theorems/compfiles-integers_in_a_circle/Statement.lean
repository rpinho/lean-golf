import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Int.ModEq
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace IntegersInACircle

theorem _root_.LeanGolf.compfiles.integers_in_a_circle
    (a : ZMod 101 → ℤ)
    (ha : ∀ i, 1 ≤ a i)
    (ha_sum : ∑ i : ZMod 101, a i = 300)
    : ∃ j : ZMod 101, ∃ n : ℕ, ∑ i ∈ Finset.range n, a (j + i) = 200 := by sorry
