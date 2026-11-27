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

def flipIx {n : ℕ} (c : Fin n → Bool) (h : numHeads c ≠ 0) : Fin n :=
  ⟨numHeads c - 1, by
    have h1 : numHeads c ≤ n := (card_le_univ _).trans (by simp)
    lia⟩

def step {n : ℕ} (c : Fin n → Bool) : Fin n → Bool :=
  if h : numHeads c = 0 then c else Function.update c (flipIx c h) (!c (flipIx c h))

def weightedSum {n : ℕ} (c : Fin n → Bool) : ℕ :=
  ∑ i : Fin n, (i.val + 1) * (if c i then 1 else 0)

def meas {n : ℕ} (c : Fin n → Bool) : ℤ :=
  2 * (weightedSum c : ℤ) - (numHeads c : ℤ) ^ 2

abbrev L {n : ℕ} (c : Fin n → Bool) : ℕ := (meas c).toNat

theorem _root_.LeanGolf.compfiles.imo2019_p5_partb_definition (n : ℕ) (c : Fin n → Bool) :
    IsLeast {m : ℕ| step^[m] c = fun _ ↦ false} (L c) := by sorry
