import Mathlib
import Mathlib.Data.Int.Interval
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa2009P2

abbrev IsGood (A : Finset ℤ) : Prop :=
  ∀ a ∈ A, ∀ b ∈ A, ∀ c ∈ A, a + b + c ≠ 0

abbrev answer (n : ℕ) : ℕ := if Even n then n else n + 1

theorem _root_.LeanGolf.compfiles.usa2009_p2 (n : ℕ) (hn : 0 < n) :
    IsGreatest
      {k : ℕ | ∃ A : Finset ℤ,
        A ⊆ Finset.Icc (-(n : ℤ)) (n : ℤ) ∧ IsGood A ∧ A.card = k}
      (answer n) := by sorry
