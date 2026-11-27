import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.LinearCombination.Lemmas
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring.Basic
import Mathlib.Tactic.Zify

noncomputable section

namespace Usa2006P2

abbrev solution : ℕ → ℕ := fun k ↦ 2 * k ^ 3 + 3 * k ^ 2 + 3 * k

theorem _root_.LeanGolf.compfiles.usa2006_p2 (k : ℕ) (hk : 0 < k) :
    IsLeast {N : ℕ | ∃ s : Finset ℕ, s.card = 2 * k + 1 ∧ (∀ x ∈ s, 0 < x) ∧
        N < ∑ x ∈ s, x ∧ ∀ t ⊆ s, t.card = k → 2 * ∑ x ∈ t, x ≤ N}
      (solution k) := by sorry
