import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.EuclideanDomain.Basic
import Mathlib.Algebra.EuclideanDomain.Field
import Mathlib.Algebra.Order.Ring.Star
import Mathlib
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.CancelDenoms.Core
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Ring

noncomputable section

namespace Usa1975P5

open Finset

def aceSets (n : ℕ) : Finset (Finset ℕ) := (Icc 1 n).powersetCard 3

def minD (S : Finset ℕ) : ℕ := (S.min).untopD 0

def maxD (S : Finset ℕ) : ℕ := (S.max).unbotD 0

def mid (S : Finset ℕ) : ℤ :=
  (∑ x ∈ S, (x : ℤ)) - (minD S : ℤ) - (maxD S : ℤ)

abbrev expected (n : ℕ) : ℚ := (n + 1) / 2

theorem _root_.LeanGolf.compfiles.usa1975_p5 (n : ℕ) (hn : 3 ≤ n) :
    (∑ S ∈ aceSets n, (mid S : ℚ)) / n.choose 3 = expected n := by sorry
