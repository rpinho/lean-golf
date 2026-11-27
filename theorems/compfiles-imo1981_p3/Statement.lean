import Mathlib.Data.Int.Lemmas
import Mathlib.Data.Nat.Fib.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination

noncomputable section

open Int Nat Set

namespace Imo1981P3

variable (N : ℕ)

structure ProblemPredicate (m n : ℤ) : Prop where
  m_range : m ∈ Ioc 0 (N : ℤ)
  n_range : n ∈ Ioc 0 (N : ℤ)
  eq_one : (n ^ 2 - m * n - m ^ 2) ^ 2 = 1

def specifiedSet : Set ℤ :=
  {k : ℤ | ∃ m : ℤ, ∃ n : ℤ, k = m ^ 2 + n ^ 2 ∧ ProblemPredicate N m n}

variable {K : ℕ} (HK : N < fib K + fib (K + 1)) {N}

variable {M : ℕ} (HM : M = fib K ^ 2 + fib (K + 1) ^ 2)

abbrev solution : ℕ := 3524578

theorem _root_.LeanGolf.compfiles.imo1981_p3 : IsGreatest (specifiedSet 1981) solution := by sorry
