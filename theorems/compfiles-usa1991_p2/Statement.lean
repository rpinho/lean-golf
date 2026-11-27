import Mathlib.Algebra.BigOperators.Group.Finset.Powerset
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Ring

namespace Usa1991P2

open Finset

theorem _root_.LeanGolf.compfiles.usa1991_p2 (n : ℕ) :
    ∑ S ∈ (Finset.Icc 1 n).powerset.erase ∅, (∑ i ∈ S, (i : ℚ)) / (∏ i ∈ S, (i : ℚ)) =
      (n : ℚ)^2 + 2 * n - (n + 1) * ∑ i ∈ Finset.Icc 1 n, (1 : ℚ) / i := by sorry
