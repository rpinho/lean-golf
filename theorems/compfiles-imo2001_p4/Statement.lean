import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Analysis.Normed.Ring.Lemmas
import Mathlib
import Mathlib.GroupTheory.Perm.Fin

noncomputable section

namespace Imo2001Q4

open Equiv Finset

open scoped Nat

variable {n : ℕ} {c : Fin n → ℤ}

def S (c : Fin n → ℤ) (a : Perm (Fin n)) : ℤ := ∑ i, c i * (a i + 1)

theorem _root_.LeanGolf.compfiles.imo2001_p4 (hn : Odd n ∧ 1 < n) :
    ∃ a b, a ≠ b ∧ (n ! : ℤ) ∣ S c a - S c b := by sorry
