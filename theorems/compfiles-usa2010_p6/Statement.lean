import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Finset.Sort
import Mathlib.Data.Fintype.BigOperators
import Mathlib
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Lemmas
import Mathlib.Tactic.Ring.Basic

noncomputable section

namespace Usa2010P6

def ValidErase (T : Finset ℤ) : Prop := ∀ x ∈ T, -x ∉ T

def score (L : List (ℤ × ℤ)) (T : Finset ℤ) : ℕ :=
  (L.filter (fun p => decide (p.1 ∈ T ∨ p.2 ∈ T))).length

structure ValidBoard (L : List (ℤ × ℤ)) : Prop where
  length_eq : L.length = 68
  nonzero : ∀ p ∈ L, p.1 ≠ 0 ∧ p.2 ≠ 0
  no_both_loops : ∀ k : ℤ, (k, k) ∈ L → (-k, -k) ∉ L

abbrev N : ℕ := 43

theorem _root_.LeanGolf.compfiles.usa2010_p6 :
    IsGreatest {m : ℕ | ∀ L : List (ℤ × ℤ), ValidBoard L →
      ∃ T : Finset ℤ, ValidErase T ∧ m ≤ score L T} N := by sorry
