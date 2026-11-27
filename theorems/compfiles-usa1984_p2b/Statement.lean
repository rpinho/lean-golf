import Mathlib.Algebra.Order.Star.Basic
import Mathlib
import Mathlib.Data.Nat.Factorization.Defs
import Mathlib.GroupTheory.GroupAction.Ring
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa1984P2

open scoped Nat

abbrev does_exist_infinite : Bool := false

theorem _root_.LeanGolf.compfiles.usa1984_p2b :
    if does_exist_infinite then
      ∃ S : Set ℕ, S.Infinite ∧ (∀ x ∈ S, 0 < x) ∧
        ∀ s : Finset ℕ, s.Nonempty → ↑s ⊆ S → ∃ m : ℕ, m ^ s.card = ∏ x ∈ s, x
    else
      ¬ ∃ S : Set ℕ, S.Infinite ∧ (∀ x ∈ S, 0 < x) ∧
        ∀ s : Finset ℕ, s.Nonempty → ↑s ⊆ S → ∃ m : ℕ, m ^ s.card = ∏ x ∈ s, x := by sorry
