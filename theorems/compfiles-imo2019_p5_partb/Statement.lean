import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.CharP.Defs
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Data.Finset.Sort
import Mathlib.Data.Fintype.BigOperators
import Mathlib
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.NormNum.Ineq
import Mathlib.Tactic.Positivity.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Zify

noncomputable section

namespace Imo2019P5

open Finset

def numHeads {n : ℕ} (c : Fin n → Bool) : ℕ :=
  (univ.filter fun i ↦ c i).card

def weightedSum {n : ℕ} (c : Fin n → Bool) : ℕ :=
  ∑ i : Fin n, (i.val + 1) * (if c i then 1 else 0)

def meas {n : ℕ} (c : Fin n → Bool) : ℤ :=
  2 * (weightedSum c : ℤ) - (numHeads c : ℤ) ^ 2

abbrev L {n : ℕ} (c : Fin n → Bool) : ℕ := (meas c).toNat

abbrev averageSteps (n : ℕ) : ℚ := n * (n + 1) / 4

theorem _root_.LeanGolf.compfiles.imo2019_p5_partb (n : ℕ) (hn : 0 < n) :
    (∑ c : Fin n → Bool, (L c : ℚ)) / 2 ^ n = averageSteps n := by sorry
