import Mathlib.Algebra.Order.Ring.Star
import Mathlib.Algebra.Ring.IsFormallyReal
import Mathlib.Analysis.Normed.Field.Lemmas
import Mathlib
import Mathlib.RingTheory.Int.Basic
import Mathlib.RingTheory.Polynomial.GaussLemma

noncomputable section

namespace Usa2006P3

open Polynomial

noncomputable def gpd (m : ℤ) : ℕ := (m.natAbs.primeFactors.max).unbotD 1

def BddCond (f : ℤ[X]) : Prop :=
  ∃ B : ℤ, ∀ n : ℕ, f.eval ((n : ℤ) ^ 2) ≠ 0 ∧
    ((gpd (f.eval ((n : ℤ) ^ 2)) : ℤ) - 2 * n ≤ B)

def Classification (f : ℤ[X]) : Prop :=
  ∃ (c : ℤ) (L : List ℤ), c ≠ 0 ∧ (∀ a ∈ L, Odd a) ∧
    f = C c * (L.map fun a ↦ C 4 * X - C (a ^ 2)).prod

theorem _root_.LeanGolf.compfiles.usa2006_p3 (f : ℤ[X]) : BddCond f ↔ Classification f := by sorry
