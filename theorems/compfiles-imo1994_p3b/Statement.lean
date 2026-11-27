import Mathlib.Algebra.Group.Nat.Even
import Mathlib.Algebra.Order.GroupWithZero.Basic
import Mathlib.Algebra.Ring.Parity
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Nat.Digits.Defs
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Order.Monotone.Basic
import Mathlib.Tactic

noncomputable section

namespace Imo1994P3

def ones (n : ℕ) : ℕ := (Nat.digits 2 n).sum

def f (k : ℕ) : ℕ := ((Finset.Icc (k + 1) (2 * k)).filter fun n => ones n = 3).card

abbrev answer : Set ℕ := {m | ∃ n : ℕ, 2 ≤ n ∧ m = Nat.choose n 2 + 1}

theorem _root_.LeanGolf.compfiles.imo1994_p3b : {m : ℕ | 0 < m ∧ ∃! k : ℕ, 0 < k ∧ f k = m} = answer := by sorry
