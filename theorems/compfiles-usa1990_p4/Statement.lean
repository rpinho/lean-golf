import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Nat.Digits.Lemmas
import Mathlib.Data.Set.Card
import Mathlib.Data.Set.Finite.Lattice
import Mathlib.Order.CompletePartialOrder

noncomputable section

namespace Usa1990P4

def DiffByOne (l : List ℕ) : Prop :=
  ∀ i, ∀ (_ : i + 1 < l.length), ∃ j, i < j ∧ j < l.length ∧ ∀ (_ : j < l.length),
    (l[i] + 1 = l[j] ∨ l[j] + 1 = l[i])

abbrev answer (n : ℕ) : ℕ := 2 ^ (n + 1) - 2 * n - 2

theorem _root_.LeanGolf.compfiles.usa1990_p4 (n : ℕ) (hn : 2 ≤ n) :
    Set.ncard {m : ℕ | 0 < m ∧ (Nat.digits n m).Nodup ∧ DiffByOne (Nat.digits n m)} =
      answer n := by sorry
