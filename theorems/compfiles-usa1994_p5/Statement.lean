import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Ring.Basic

namespace Usa1994P5

theorem _root_.LeanGolf.compfiles.usa1994_p5 (S : Finset ℕ) (_hS : ∀ s ∈ S, 0 < s) (m : ℕ) (hm : ∑ s ∈ S, s ≤ m) :
    ∑ U ∈ S.powerset, (-1 : ℤ) ^ U.card * ((m - ∑ s ∈ U, s).choose S.card : ℤ)
      = ∏ s ∈ S, s := by sorry
